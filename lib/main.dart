import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/constants/app_tokens.dart';
import 'core/utils/app_screen_util.dart';
import 'features/portfolio/viewmodels/portfolio_controller.dart';
import 'features/portfolio/views/screens/portfolio_screen.dart';

void main() {
  runApp(const PortfolioApp());
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
      builder: (context, child) {
        AppScreenUtil.init(context);
        return child ?? const SizedBox.shrink();
      },
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
