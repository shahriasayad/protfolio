import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';

class PortfolioBackdrop extends StatelessWidget {
  const PortfolioBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    final width = math.max<double>(AppScreenUtil.screenWidth, 1.0);
    final height = math.max<double>(AppScreenUtil.screenHeight, 1.0);

    return IgnorePointer(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppTokens.bg, AppTokens.surfaceSoft],
              ),
            ),
          ),
          Positioned(
            top: -height * 0.1,
            right: -width * 0.1,
            child: _GlowOrb(color: AppTokens.glowBlue, size: width * 0.55),
          ),
          Positioned(
            top: height * 0.18,
            left: -width * 0.15,
            child: _GlowOrb(color: AppTokens.glowCyan, size: width * 0.42),
          ),
          Positioned(
            bottom: height * 0.1,
            right: width * 0.08,
            child: _GlowOrb(color: AppTokens.glowPink, size: width * 0.28),
          ),
          CustomPaint(size: Size(width, height), painter: _GridPainter()),
        ],
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final Color color;
  final double size;

  const _GlowOrb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withValues(alpha: 0.0)]),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..strokeWidth = 1;

    const gap = 72.0;
    for (double x = 0; x < size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
