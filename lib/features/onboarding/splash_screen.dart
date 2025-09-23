import 'package:beclean/core/config/app_colors.dart';
import 'package:beclean/core/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _checkToken() async {
    final authVM = context.read<AuthViewModel>();
    final navigator = Navigator.of(context);
    String route = AppRoutes.login;

    final results = await Future.wait([
      authVM.loadProfile(),
      Future.delayed(const Duration(seconds: 2)),
    ]);

    if (results[0]) {
      if (authVM.role == "user") {
        route = AppRoutes.homeUser;
      }
      if (authVM.role == "driver") {
        route = AppRoutes.homeCollector;
      }
    }

    navigator.pushReplacementNamed(route);
  }

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          height: 150,
          width: 150, // <-- Atur lebar gambar
        ),
      ),
    );
  }
}
