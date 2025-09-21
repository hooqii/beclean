import 'package:flutter/material.dart';
import 'package:beclean/core/config/app_colors.dart';

class WithdrawPage extends StatefulWidget {
  final List<Map<String, String>> accounts;
  final int balance;

  const WithdrawPage({
    super.key,
    required this.accounts,
    required this.balance,
  });

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedAccount;
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                "Saldo Tersedia: Rp ${widget.balance}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),

              /// Dropdown pilih akun
              DropdownButtonFormField<String>(
                isExpanded: true,
                value: _selectedAccount,
                decoration: InputDecoration(
                  labelText: "Pilih Rekening / E-Wallet",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: widget.accounts.map((acc) {
                  final display = "${acc['provider']} - ${acc['number']}";
                  return DropdownMenuItem(value: display, child: Text(display));
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
                        _amountController.text = widget.balance.toString();
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
                  if (amount > widget.balance) {
                    return "Saldo tidak mencukupi";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              /// Tombol Cairkan
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final amount = int.parse(_amountController.text);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Pencairan Rp $amount berhasil dikirim ke $_selectedAccount",
                          ),
                          backgroundColor: AppColors.primary,
                        ),
                      );

                      Navigator.pop(context); // kembali ke home
                    }
                  },
                  child: const Text(
                    "Cairkan",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
