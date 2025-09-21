import 'package:beclean/core/view_models/auth_view_model.dart';
import 'package:beclean/shared/widgets/error_view.dart';
import 'package:beclean/shared/widgets/glass_button.dart';
import 'package:flutter/material.dart';
import 'package:beclean/core/config/app_colors.dart';
import 'package:provider/provider.dart';

class ManagePasswordUserPage extends StatefulWidget {
  const ManagePasswordUserPage({super.key});

  @override
  State<ManagePasswordUserPage> createState() => _ManagePasswordUserPageState();
}

class _ManagePasswordUserPageState extends State<ManagePasswordUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _loading = false;
  String? _error;

  String? _newPassValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password baru tidak boleh kosong";
    }
    if (_newPasswordController.text != _confirmPasswordController.text) {
      return "Kedua password tidak sama";
    }
    return null;
  }

  void _updatePassword() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });

    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    final oldPassword = _oldPasswordController.text;
    final newPassword = _newPasswordController.text;
    final error = await context.read<AuthViewModel>().updatePassword(
      oldPassword,
      newPassword,
    );

    if (error == null) {
      navigator.pop();
      messenger.showSnackBar(
        const SnackBar(
          content: Text("Password berhasil diperbarui"),
          backgroundColor: AppColors.primary,
        ),
      );
      return;
    }
    setState(() {
      _loading = false;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    final nama = context.read<AuthViewModel>().currentUser!.nama;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kelola Password",
          style: TextStyle(color: Color.fromARGB(255, 23, 87, 14)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 23, 87, 14)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            /// Foto Profile
            const CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage("assets/images/profile.png"),
            ),
            const SizedBox(height: 16),
            Text(
              nama,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 30),

            /// Form Update Password
            Form(
              key: _formKey,
              child: Column(
                children: [
                  ErrorView(error: _error),
                  const SizedBox(height: 8),
                  _PasswordField(
                    controller: _oldPasswordController,
                    label: "Password Lama",
                  ),
                  const SizedBox(height: 16),
                  _PasswordField(
                    controller: _newPasswordController,
                    label: "Password Baru",
                    validator: _newPassValidator,
                  ),
                  const SizedBox(height: 16),
                  _PasswordField(
                    controller: _confirmPasswordController,
                    label: "Konfirmasi Password Baru",
                    validator: _newPassValidator,
                  ),
                  const SizedBox(height: 30),

                  /// Tombol Simpan
                  GlassButton(
                    onPressed: _updatePassword,
                    text: "Update Password",
                    loading: _loading,
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

class _PasswordField extends StatefulWidget {
  const _PasswordField({
    required this.controller,
    required this.label,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String? value)? validator;

  @override
  State<_PasswordField> createState() => __PasswordFieldState();
}

class __PasswordFieldState extends State<_PasswordField> {
  bool _show = false;

  void _toggle() {
    setState(() => _show = !_show);
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return "${widget.label} tidak boleh kosong";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: !_show,
      validator: widget.validator ?? _validator,
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: IconButton(
          icon: Icon(!_show ? Icons.visibility_off : Icons.visibility),
          onPressed: _toggle,
        ),
      ),
    );
  }
}
