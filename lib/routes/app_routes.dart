import 'package:beclean/features/collector/history/views/collector_history_page.dart';
import 'package:beclean/features/collector/pickup/views/collector_pickup_schedule_page.dart';
import 'package:beclean/features/user/pickup_schedule/views/user_pickup_schedule_page.dart';
import 'package:beclean/features/user/profile/view_models/payment_account_view_model.dart';
import 'package:beclean/features/user/profile/views/payment_account_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/onboarding/splash_screen.dart';
// import '../features/onboarding/onboarding_page.dart';
import '../features/auth/views/login_page.dart';
import '../features/auth/views/register_page.dart';
import '../features/user/layouts/user_layout.dart';
import '../features/user/product/views/product_page.dart';
import '../features/user/activity/views/activity_page.dart';
import '../features/user/profile/views/profile_page.dart';
import '../features/user/recycle_history/views/recycle_history_page.dart';
import '../features/collector/home/views/collector_home_page.dart';
import '../features/collector/pickup/views/pickup_list_page.dart';

class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  // static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const homeUser = '/home_user';
  static const productUser = '/product_user';
  static const activityUser = '/activity_user';
  static const profileUser = '/profile_user';
  static const pickupAddress = '/pickupAddress';
  static const homeCollector = '/home_collector';
  static const pickupCollector = '/pickup_collector';
  static const pickupScheduleUser = '/pickup_schedule_user';
  static const pickupScheduleCollector = '/pickup_schedule_collector';
  static const userPickupList = '/user_pickup_list';
  static const collectorHistory = '/collector_history';
  static const inputWeight = '/input_weight';
  static const paymentAccount = '/payment_account';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      login: (context) => const LoginPage(),
      register: (context) => const RegisterPage(),
      homeUser: (context) => const UserLayout(),
      productUser: (context) => const ProductPage(),
      activityUser: (context) => const ActivityPage(),
      profileUser: (context) => const ProfilePage(),
      pickupAddress: (context) => const HistoryPage(),
      homeCollector: (context) => const CollectorHomePage(),
      pickupScheduleUser: (context) {
        final args =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
        return UserPickupSchedulePage(
          title: args?["title"],
        );
      },
      pickupScheduleCollector: (context) {
        final args =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
        return CollectorPickupSchedulePage(
          title: args?["title"],
        );
      },
      userPickupList: (context) => const UserPickupListPage(),
      collectorHistory: (context) => const CollectorHistoryPage(),
      paymentAccount: (context) {
        return ChangeNotifierProvider(
          create: (context) => PaymentAccountViewModel(),
          child: const PaymentAccountPage(),
        );
      },
    };
  }
}
