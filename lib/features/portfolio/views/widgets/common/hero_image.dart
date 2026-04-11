import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import '../../../viewmodels/portfolio_controller.dart';

/// Hero image - Profile picture with animation
class HeroImage extends StatefulWidget {
  final PortfolioController ctrl;
  const HeroImage(this.ctrl, {super.key});

  @override
  State<HeroImage> createState() => _HeroImageState();
}

class _HeroImageState extends State<HeroImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _ac;

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.8,
        end: 1.0,
      ).animate(CurvedAnimation(parent: _ac, curve: Curves.easeOutCubic)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 280, maxHeight: 280),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTokens.r24),
          border: Border.all(color: AppTokens.border, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppTokens.accent.withValues(alpha: 0.2),
              blurRadius: 40,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppTokens.r24),
          child: Image.asset(
            widget.ctrl.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (ctx, err, stack) => Container(
              color: AppTokens.surfaceAlt,
              child: Center(
                child: Icon(
                  Icons.person_outline,
                  size: 80,
                  color: AppTokens.accent.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
