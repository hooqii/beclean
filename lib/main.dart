import 'package:beclean/core/view_models/auth_view_model.dart';
import 'package:beclean/core/view_models/mutation_view_model.dart';
import 'package:beclean/core/view_models/schedule_view_model.dart';
import 'package:beclean/features/user/product/view_models/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'routes/app_routes.dart';
import 'core/config/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Biar status bar & nav bar transparan full edge-to-edge
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarContrastEnforced: true,
    ),
  );

  Intl.defaultLocale = "id_ID";
  initializeDateFormatting("id_ID");

  runApp(const BeCleanApp());
}

class BeCleanApp extends StatelessWidget {
  const BeCleanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => ProductViewModel()),
        ChangeNotifierProvider(create: (context) => ScheduleViewModel()),
        ChangeNotifierProvider(create: (context) => MutationViewModel()),
      ],
      child: MaterialApp(
        title: 'BeClean',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.getRoutes(),
      ),
    );
  }
}
