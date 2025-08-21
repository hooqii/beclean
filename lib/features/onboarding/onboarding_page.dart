import 'package:beclean/core/config/app_colors.dart';
import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Biar konten bisa masuk ke bawah navigation bar
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Hero(
            tag: 'logo-tag',
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/image.png'),
                const SizedBox(height: 20),
                const Text(
                  'Selamat Datang di BeClean!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poopins',
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Aplikasi pengelolaan pengangkutan sampah rumah tangga dan daur ulang.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Poopins'),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  width: 255,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    child: const Text('Selanjutnya'),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, AppRoutes.login),
                  child: const Text('Lewati'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}