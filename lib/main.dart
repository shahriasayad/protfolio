import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'core/constants/app_tokens.dart';
import 'core/utils/app_screen_util.dart';
import 'features/portfolio/viewmodels/portfolio_controller.dart';
import 'features/portfolio/views/screens/portfolio_screen.dart';

void main() {
  _configLoading();
  runApp(const PortfolioApp());
}

void _configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = AppTokens.accent
    ..backgroundColor = AppTokens.surface
    ..indicatorColor = AppTokens.accent
    ..textColor = AppTokens.textPrimary
    ..maskColor = AppTokens.bg.withValues(alpha: 0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

/// Root application widget
class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(PortfolioController(), permanent: true);
      }),
      builder: EasyLoading.init(
        builder: (context, child) {
          AppScreenUtil.init(context);
          return child ?? const SizedBox.shrink();
        },
      ),
      title: 'Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppTokens.bg,
        colorScheme: const ColorScheme.dark(
          primary: AppTokens.accent,
          surface: AppTokens.surface,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      ),
      home: const PortfolioPage(),
    );
  }
}
