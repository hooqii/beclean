import 'package:flutter/material.dart';
import '../features/onboarding/splash_screen.dart';
// import '../features/onboarding/onboarding_page.dart';
import '../features/auth/login_page.dart';
import '../features/auth/register_page.dart';
import '../features/user/user_main_page.dart';
import '../features/user/product_page.dart';
import '../features/user/activity_page.dart';
import '../features/user/profile_page.dart';
import '../features/user/request_pickup_page.dart';
import '../features/collector/dashboard_page.dart';
import '../features/collector/pickup_page.dart';

class AppRoutes {
  static const splash = '/';
  // static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const homeUser = '/home_user';
  static const productUser = '/product_user';
  static const activityUser = '/activity_user';
  static const profileUser = '/profile_user';
  static const requestPickupUser = '/request_pickup_user';
  static const dashboardCollector = '/dashboard_collector';
  static const pickupCollector = '/pickup_collector';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      // onboarding: (context) => const OnboardingPage(),
      login: (context) => const LoginPage(),
      register: (context) => const RegisterPage(),
      homeUser: (context) => const UserMainPage(),
      productUser: (context) => const ProductPage(),
      activityUser: (context) => const ActivityPage(),
      profileUser: (context) => const ProfilePage(),
      requestPickupUser: (context) => const RequestPickupPage(),
      dashboardCollector: (context) => const DashboardCollectorPage(),
      pickupCollector: (context) => const PickupPage(),
    };
  }
}
