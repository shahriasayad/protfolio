import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/constants/app_tokens.dart';
import 'core/utils/app_screen_util.dart';
import 'features/portfolio/services/portfolio_service.dart';
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
    ..indicatorSize = 40.0
    ..radius = AppTokens.r8
    ..progressColor = AppTokens.accent
    ..backgroundColor = AppTokens.surfaceElevated
    ..indicatorColor = AppTokens.accent
    ..textColor = AppTokens.textPrimary
    ..maskColor = AppTokens.bg.withValues(alpha: 0.6)
    ..userInteractions = false
    ..dismissOnTap = false;
}

/// Root application widget configuring GetX DI, theme, and EasyLoading.
class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(PortfolioService(), permanent: true);
        Get.put(PortfolioController(), permanent: true);
      }),
      builder: EasyLoading.init(
        builder: (context, child) {
          AppScreenUtil.init(context);
          return child ?? const SizedBox.shrink();
        },
      ),
      title: 'Shahria Sayad — Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppTokens.bg,
        colorScheme: const ColorScheme.dark(
          primary: AppTokens.accent,
          surface: AppTokens.surface,
          onPrimary: AppTokens.bg,
          onSurface: AppTokens.textPrimary,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      ),
      home: const PortfolioPage(),
    );
  }
}
