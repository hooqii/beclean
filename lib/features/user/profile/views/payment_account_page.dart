import 'package:beclean/core/models/payment_account.dart';
import 'package:beclean/core/view_models/auth_view_model.dart';
import 'package:beclean/features/user/profile/view_models/payment_account_view_model.dart';
import 'package:beclean/shared/widgets/glass_button.dart';
import 'package:flutter/material.dart';
import 'package:beclean/core/config/app_colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:provider/provider.dart';
import '../models/payment_merchant.dart';

class PaymentAccountPage extends StatefulWidget {
  const PaymentAccountPage({super.key});

  @override
  State<PaymentAccountPage> createState() => _PaymentAccountPageState();
}

class _PaymentAccountPageState extends State<PaymentAccountPage> {
  final _formKey = GlobalKey<FormState>();

  String _selectedMethod = "Bank"; // default Bank
  String? _selectedBank;
  String? _selectedWallet;

  final _accountNumberController = TextEditingController();
  final _walletNumberController = TextEditingController();

  bool _isAdding = false; // toggle untuk tampilkan form tambah akun
  bool _loading = false;

  void _remove(PaymentAccount account) async {
    final authVM = context.read<AuthViewModel>();
    final messenger = ScaffoldMessenger.of(context);
    final error = await context.read<PaymentAccountViewModel>().removeAccount(
      account.id,
    );
    if (error == null) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            "${account.merchant.name} (${account.nomor}) berhasil dihapus",
          ),
          backgroundColor: Colors.lightGreen,
        ),
      );
      authVM.getProfile();
      return;
    }
    messenger.showSnackBar(
      const SnackBar(
        content: Text(
          "Gagal menghapus akun",
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _add() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    final authVM = context.read<AuthViewModel>();
    final messenger = ScaffoldMessenger.of(context);

    final merchant = _selectedBank ?? _selectedWallet!;
    String nomor = _accountNumberController.text.trim();
    if (nomor.isEmpty) nomor = _walletNumberController.text.trim();

    final error = await context.read<PaymentAccountViewModel>().addAccount(
      merchant,
      nomor,
    );

    setState(() => _loading = false);

    if (error == null) {
      setState(() {
        _isAdding = false;
        _selectedBank = null;
        _selectedWallet = null;
        _accountNumberController.clear();
        _walletNumberController.clear();
      });

      messenger.showSnackBar(
        const SnackBar(
          content: Text("Akun berhasil ditambahkan"),
          backgroundColor: AppColors.primary,
        ),
      );

      authVM.getProfile();
      return;
    }

    messenger.showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accounts = context.watch<AuthViewModel>().currentUser!.rekening;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rekening Pembayaran",
          style: TextStyle(color: Color.fromARGB(255, 23, 87, 14)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 23, 87, 14)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ===== LIST REKENING / WALLET =====
            const Text(
              "Akun Tersimpan",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            if (accounts.isEmpty) const Text("Belum ada akun tersimpan."),
            ...accounts.map(
              (acc) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(
                      acc.type == "Bank" ? Icons.account_balance : Icons.wallet,
                      color: AppColors.primary,
                    ),
                    title: Text(acc.merchant.name),
                    subtitle: Text(acc.nomor),

                    /// 👉 Tambahin tombol delete di sebelah kanan
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.lightGreen),
                      onPressed: () => _remove(acc),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            /// ===== TOMBOL TAMBAH =====
            if (!_isAdding)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text("Tambah Rekening / E-Wallet"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    setState(() => _isAdding = true);
                  },
                ),
              ),

            /// ===== FORM TAMBAH =====
            if (_isAdding)
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Tambah Akun Baru",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),

                    /// Pilih metode
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: const Text("Bank"),
                            value: "Bank",
                            groupValue: _selectedMethod,
                            onChanged: (value) {
                              setState(
                                () => _selectedMethod = value.toString(),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: const Text("E-Wallet"),
                            value: "E-Wallet",
                            groupValue: _selectedMethod,
                            onChanged: (value) {
                              setState(
                                () => _selectedMethod = value.toString(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    /// Form Bank
                    if (_selectedMethod == "Bank") ...[
                      DropdownButtonFormField2<String>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12,
                          ),
                        ),
                        hint: const Text("Pilih Bank"),
                        value: _selectedBank,
                        items: banks
                            .map(
                              (bank) => DropdownMenuItem(
                                value: bank.id,
                                child: Text(
                                  bank.name,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() => _selectedBank = value);
                        },
                        validator: (value) =>
                            value == null ? "Pilih bank terlebih dahulu" : null,
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _accountNumberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Nomor Rekening",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.only(
                            top: 16,
                            right: 16,
                            bottom: 16,
                            left: 24,
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? "Nomor rekening wajib diisi"
                            : null,
                      ),
                    ],

                    /// Form E-Wallet
                    if (_selectedMethod == "E-Wallet") ...[
                      DropdownButtonFormField2<String>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12,
                          ),
                        ),
                        hint: const Text("Pilih E-Wallet"),
                        value: _selectedWallet,
                        items: wallets
                            .map(
                              (wallet) => DropdownMenuItem(
                                value: wallet.id,
                                child: Text(
                                  wallet.name,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() => _selectedWallet = value);
                        },
                        validator: (value) =>
                            value == null ? "Pilih provider e-wallet" : null,
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _walletNumberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Nomor E-Wallet",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.only(
                            top: 16,
                            right: 16,
                            bottom: 16,
                            left: 24,
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? "Nomor E-Wallet wajib diisi"
                            : null,
                      ),
                    ],

                    const SizedBox(height: 30),

                    /// Tombol Simpan
                    Row(
                      children: [
                        Expanded(
                          child: GlassButton(
                            onPressed: _add,
                            text: "Simpan",
                            loading: _loading,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              setState(() => _isAdding = false);
                            },
                            child: const Text("Batal"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
