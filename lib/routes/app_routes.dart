import 'package:beclean/features/user/pickup_schedule_page.dart';
import 'package:flutter/material.dart';
import '../features/onboarding/splash_screen.dart';
// import '../features/onboarding/onboarding_page.dart';
import '../features/auth/login_page.dart';
import '../features/auth/register_page.dart';
import '../features/user/user_main_page.dart';
import '../features/user/product_page.dart';
import '../features/user/activity_page.dart';
import '../features/user/profile_page.dart';
import '../features/user/recycle_history_page.dart';
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
  static const pickupAddress = '/pickupAddress';
  static const dashboardCollector = '/dashboard_collector';
  static const pickupCollector = '/pickup_collector';
  static const pickupSchedule = '/pickup_schedule';

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
      pickupAddress: (context) => const HistoryPage(),
      dashboardCollector: (context) => const DashboardCollectorPage(),
      pickupCollector: (context) => const PickupPage(),
      pickupSchedule: (context) => const PickupSchedulePage(),
    };
  }
}
