import 'package:beclean/core/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import '../../routes/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isPasswordObscured = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                _buildGlassContainer(
                  child: Column(
                    children: [
                      _buildGlassTextField(
                        controller: emailController,
                        hintText: 'Email',
                        icon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 16),
                      _buildGlassTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        icon: Icons.lock_outline,
                        obscureText: _isPasswordObscured,
                        suffixIcon: Padding(
                          // Atur jarak kanan ikon di sini.
                          // Semakin besar nilainya, semakin jauh ikon dari tepi kanan.
                          padding: const EdgeInsets.only(right: 2.0),
                          child: IconButton(
                            icon: Icon(
                              _isPasswordObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordObscured = !_isPasswordObscured;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildGlassButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.homeUser,
                          );
                        },
                        text: 'Masuk',
                        isPrimary: true,
                      ),
                      const SizedBox(height: 12),
                      // _buildGlassButton(
                      //   onPressed: () {
                      //     Navigator.pushReplacementNamed(
                      //       context,
                      //       AppRoutes.dashboardCollector,
                      //     );
                      //   },
                      //   text: 'Login sebagai collector',
                      // ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.register),
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

  // Helper widget untuk container glassmorphism utama
  Widget _buildGlassContainer({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 45.0,
            bottom: 45.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  // Helper widget untuk TextField dengan efek glass
  Widget _buildGlassTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          color: Colors.white.withOpacity(0.2),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(icon, color: Colors.white),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
            ),
            keyboardType: obscureText
                ? TextInputType.visiblePassword
                : TextInputType.emailAddress,
          ),
        ),
      ),
    );
  }

  // Helper widget untuk Button dengan efek glass
  Widget _buildGlassButton({
    required VoidCallback onPressed,
    required String text,
    bool isPrimary = false,
  }) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: isPrimary
                  ? AppColors.primary.withOpacity(0.9)
                  : Colors.white.withOpacity(0.25),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                // borderRadius: BorderRadius.circular(99),
                side: isPrimary
                    ? BorderSide.none
                    : BorderSide(color: Colors.white.withOpacity(0.5)),
              ),
              shadowColor: Colors.transparent,
            ),
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
