import 'package:beclean/core/view_models/auth_view_model.dart';
import 'package:beclean/features/auth/glass_button.dart';
import 'package:beclean/features/auth/glass_container.dart';
import 'package:beclean/features/auth/glass_text_field.dart';
import 'package:beclean/features/auth/models/new_user.dart';
import 'package:beclean/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nikController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _alamatController = TextEditingController();
  final _passwordController = TextEditingController();
  final _kPasswordController = TextEditingController();

  bool _loading = false;
  String? _error;

  void _register() async {
    if (!_validate()) return;

    final authVM = context.read<AuthViewModel>();
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final position = await _getLocation();

    if (position == null) {
      messenger.showSnackBar(
        SnackBar(
          content: Text("Gagal mengambil lokasi"),
        ),
      );
      return;
    }

    final user = NewUser(
      nik: _nikController.text.trim(),
      email: _emailController.text.trim(),
      nama: _nameController.text.trim(),
      noHp: _phoneNumberController.text.trim(),
      alamat: _alamatController.text.trim(),
      password: _passwordController.text,
      latitude: position.latitude,
      longitude: position.longitude,
    );

    final error = await authVM.register(user);
    if (error == null) {
      navigator.pushNamedAndRemoveUntil(
        AppRoutes.homeUser,
        (route) => false,
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
    if (_passwordController.text != _kPasswordController.text) {
      _error = "Kedua password tidak sama";
    }
    if (_passwordController.text.isEmpty) {
      _error = "Password tidak boleh kosong";
    }
    if (_kPasswordController.text.isEmpty) {
      _error = "Password tidak boleh kosong";
    }
    if (_alamatController.text.isEmpty) {
      _error = "Alamat tidak boleh kosong";
    }
    if (_phoneNumberController.text.isEmpty) {
      _error = "Nomor handphone tidak boleh kosong";
    }
    if (_emailController.text.isEmpty) {
      _error = "Email tidak boleh kosong";
    }
    if (_nameController.text.isEmpty) {
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

  Future<Position?> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }
    return await Geolocator.getCurrentPosition(
      locationSettings: AndroidSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _kPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Konten Register
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 45),
                const Image(
                  image: AssetImage('assets/images/logo.png'),
                  height: 150,
                  width: 150,
                ),
                const SizedBox(height: 25),
                GlassContainer(
                  child: Column(
                    children: [
                      Text(
                        _error ?? "",
                        style: TextStyle(color: Colors.red.shade800),
                      ),
                      SizedBox(height: 8),
                      GlassTextField(
                        controller: _nikController,
                        hintText: 'NIK',
                        icon: Icons.assignment_ind_outlined,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      GlassTextField(
                        controller: _nameController,
                        hintText: 'Nama',
                        icon: Icons.person,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 16),
                      GlassTextField(
                        controller: _emailController,
                        hintText: 'Email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      GlassTextField(
                        controller: _phoneNumberController,
                        hintText: 'Nomor Handphone',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 16),
                      GlassTextField(
                        controller: _alamatController,
                        hintText: 'Alamat',
                        icon: Icons.location_on_outlined,
                      ),
                      const SizedBox(height: 16),
                      GlassTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                        icon: Icons.lock_outline,
                        isPassword: true,
                      ),
                      const SizedBox(height: 16),
                      GlassTextField(
                        controller: _kPasswordController,
                        hintText: 'Konfirmasi Password',
                        icon: Icons.lock_outline,
                        isPassword: true,
                      ),
                      const SizedBox(height: 24),
                      GlassButton(
                        onPressed: _register,
                        text: 'Daftar akun',
                        loading: _loading,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Sudah punya akun? Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
