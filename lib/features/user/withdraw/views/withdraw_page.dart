import 'package:beclean/core/models/payment_account.dart';
import 'package:beclean/core/utils/app_helpers.dart';
import 'package:beclean/core/view_models/auth_view_model.dart';
import 'package:beclean/core/view_models/mutation_view_model.dart';
import 'package:beclean/shared/widgets/error_view.dart';
import 'package:beclean/shared/widgets/glass_button.dart';
import 'package:flutter/material.dart';
import 'package:beclean/core/config/app_colors.dart';
import 'package:provider/provider.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  PaymentAccount? _selectedAccount;
  bool _loading = false;
  String? _error;

  void _withdraw() async {
    if (!_formKey.currentState!.validate()) return;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final mutationVM = context.read<MutationViewModel>();
    final authVM = context.read<AuthViewModel>();

    final jumlah = int.parse(_amountController.text);
    final rekening = _selectedAccount!.id;

    setState(() {
      _loading = true;
      _error = null;
    });
    final error = await mutationVM.withdraw(rekening, jumlah);

    if (error == null) {
      await authVM.getProfile();
      final display =
          "${_selectedAccount!.merchant.name} - ${_selectedAccount!.nomor}";
      final jumlahString = AppHelpers.formatHarga(jumlah);
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            "Pencairan $jumlahString berhasil dikirim ke $display",
          ),
          backgroundColor: AppColors.primary,
        ),
      );

      return navigator.pop();
    }

    setState(() {
      _loading = false;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthViewModel>().currentUser!;
    final balance = user.saldo;
    final accounts = user.rekening;
    final balanceString = AppHelpers.formatHarga(balance);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pencairan Saldo",
          style: TextStyle(color: Color.fromARGB(255, 23, 87, 14)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 23, 87, 14)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Saldo info
              Text(
                "Saldo Tersedia: $balanceString",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),

              /// Error View
              Center(child: ErrorView(error: _error)),

              /// Dropdown pilih akun
              DropdownButtonFormField<PaymentAccount>(
                isExpanded: true,
                value: _selectedAccount,
                decoration: InputDecoration(
                  labelText: "Pilih Rekening / E-Wallet",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: accounts.map((acc) {
                  final display = "${acc.merchant.name} - ${acc.nomor}";
                  return DropdownMenuItem(
                    value: acc,
                    child: Text(display),
                  );
                }).toList(),
                onChanged: (value) => setState(() {
                  _selectedAccount = value;
                }),
                validator: (value) =>
                    value == null ? "Pilih akun tujuan pencairan" : null,
              ),
              const SizedBox(height: 16),

              /// Input jumlah
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Jumlah Pencairan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: TextButton(
                    onPressed: () {
                      setState(() {
                        _amountController.text = balanceString;
                      });
                    },
                    child: const Text(
                      "MAX",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Masukkan jumlah pencairan";
                  }
                  final amount = int.tryParse(value) ?? 0;
                  if (amount <= 0) return "Jumlah tidak valid";
                  if (amount > balance) {
                    return "Saldo tidak mencukupi";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              /// Tombol Cairkan
              GlassButton(
                onPressed: _withdraw,
                text: "Tarik Saldo",
                loading: _loading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
