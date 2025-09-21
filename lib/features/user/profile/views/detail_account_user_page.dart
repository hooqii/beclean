import 'package:beclean/core/view_models/auth_view_model.dart';
import 'package:beclean/features/user/profile/models/account_details.dart';
import 'package:beclean/shared/widgets/error_view.dart';
import 'package:beclean/shared/widgets/glass_button.dart';
import 'package:flutter/material.dart';
import 'package:beclean/core/config/app_colors.dart';
import 'package:provider/provider.dart';

class DetailAccountUserPage extends StatefulWidget {
  const DetailAccountUserPage({super.key});

  @override
  State<DetailAccountUserPage> createState() => _DetailAccountUserPageState();
}

class _DetailAccountUserPageState extends State<DetailAccountUserPage> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nikController = TextEditingController();
  final _alamatController = TextEditingController();

  bool _loading = false;
  String? _error;

  void _loadTexts() {
    final user = context.read<AuthViewModel>().currentUser!;
    _namaController.text = user.nama;
    _emailController.text = user.email;
    _phoneController.text = user.noHp;
    _nikController.text = user.nik;
    _alamatController.text = user.alamat;
  }

  void _updateProfile() async {
    if (!_validate()) return;

    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    final account = AccountDetails(
      nik: _nikController.text.trim(),
      nama: _namaController.text.trim(),
      email: _emailController.text.trim(),
      noHp: _phoneController.text.trim(),
      alamat: _alamatController.text.trim(),
    );

    final error = await context.read<AuthViewModel>().updateProfil(account);
    if (error == null) {
      navigator.pop();
      messenger.showSnackBar(
        const SnackBar(
          content: Text("Berhasil update profil"),
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

  bool _validate() {
    setState(() {
      _loading = true;
      _error = null;
    });
    if (_alamatController.text.isEmpty) {
      _error = "Alamat tidak boleh kosong";
    }
    if (_phoneController.text.isEmpty) {
      _error = "Nomor handphone tidak boleh kosong";
    }
    if (_emailController.text.isEmpty) {
      _error = "Email tidak boleh kosong";
    }
    if (_namaController.text.isEmpty) {
      _error = "Nama tidak boleh kosong";
    }
    if (_nikController.text.isEmpty) {
      _error = "NIK tidak boleh kosong";
    }
    if (_error != null) {
      setState(() => _loading = false);
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _loadTexts();
  }

  @override
  void dispose() {
    super.dispose();
    _namaController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nikController.dispose();
    _alamatController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Akun",
          style: TextStyle(color: Color.fromARGB(255, 23, 87, 14)),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 23, 87, 14)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),

            /// Foto Profile
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            const SizedBox(height: 36),

            /// Error View
            ErrorView(error: _error),

            /// NIK
            _AccountTextField(
              controller: _nikController,
              label: "NIK",
              icon: Icons.assignment_ind_outlined,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 18),

            /// Username
            _AccountTextField(
              controller: _namaController,
              label: "Nama",
              icon: Icons.person,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 18),

            /// Email
            _AccountTextField(
              controller: _emailController,
              label: "Email",
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 18),

            /// Nomor HP
            _AccountTextField(
              controller: _phoneController,
              label: "Nomor HP",
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 30),

            /// Alamat
            _AccountTextField(
              controller: _alamatController,
              label: "Alamat",
              icon: Icons.location_on,
            ),
            const SizedBox(height: 30),

            /// Tombol Simpan
            GlassButton(
              onPressed: _updateProfile,
              text: "Simpan Perubahan",
              loading: _loading,
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountTextField extends StatelessWidget {
  const _AccountTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.primary),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color.fromARGB(100, 23, 87, 14)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
