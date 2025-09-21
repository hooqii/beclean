import 'package:beclean/core/view_models/auth_view_model.dart';
import 'package:beclean/features/auth/glass_button.dart';
import 'package:beclean/features/auth/glass_container.dart';
import 'package:beclean/features/auth/glass_text_field.dart';
import 'package:beclean/shared/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../routes/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;
  String? _error;

  void _login() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final authVM = context.read<AuthViewModel>();
    final navigator = Navigator.of(context);

    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final error = await authVM.login(email, password);

    if (error == null) {
      final role = authVM.role;
      final route = role == "user"
          ? AppRoutes.homeUser
          : AppRoutes.homeCollector;
      navigator.pushNamedAndRemoveUntil(route, (route) => false);
      return;
    }

    setState(() {
      _loading = false;
      _error = error;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      // 1. Gunakan Stack untuk menumpuk background dan konten
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/background.png',
                ), // Ganti dengan gambar background Anda
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Konten Login
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 45),
                Image(
                  image: const AssetImage('assets/images/logo.png'),
                  height: 150,
                  width: 150,
                ),
                const Text(
                  'Partner untuk mengelola sampahmu!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 19, 75, 23),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                // Card Glassmorphism untuk form
                GlassContainer(
                  child: Column(
                    children: [
                      ErrorView(error: _error),
                      GlassTextField(
                        controller: _emailController,
                        hintText: 'Email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      GlassTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                        icon: Icons.lock_outline,
                        isPassword: true,
                      ),
                      const SizedBox(height: 24),
                      GlassButton(
                        onPressed: _login,
                        text: 'Masuk',
                        loading: _loading,
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.register);
                  },
                  child: const Text(
                    'Belum punya akun? Register',
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
