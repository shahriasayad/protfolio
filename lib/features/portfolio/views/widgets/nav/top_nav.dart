import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';

/// Top navigation bar
class TopNav extends StatelessWidget {
  final int activeIndex;
  final VoidCallback onHero,
      onAbout,
      onSkills,
      onProjects,
      onEducation,
      onExperience,
      onContact;

  const TopNav({
    super.key,
    required this.activeIndex,
    required this.onHero,
    required this.onAbout,
    required this.onSkills,
    required this.onProjects,
    required this.onEducation,
    required this.onExperience,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = AppScreenUtil.screenWidth > 640;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppTokens.border.withValues(alpha: 0.35)),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppTokens.s24.w,
        vertical: AppTokens.s14.h,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onHero,
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTokens.accent, AppTokens.accentBlue],
                    ),
                    borderRadius: BorderRadius.circular(AppTokens.r12.r),
                  ),
                  child: const Icon(
                    Icons.flutter_dash,
                    color: AppTokens.bg,
                    size: 18,
                  ),
                ),
                SizedBox(width: AppTokens.s12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shahria Sayad',
                      style: GoogleFonts.spaceGrotesk(
                        color: AppTokens.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      'Flutter developer',
                      style: GoogleFonts.inter(
                        color: AppTokens.textMuted,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          if (isWide) ...[
            NavItem('About', onAbout, isActive: activeIndex == 1),
            NavItem('Experience', onExperience, isActive: activeIndex == 2),
            NavItem('Projects', onProjects, isActive: activeIndex == 3),
            NavItem('Skills', onSkills, isActive: activeIndex == 4),
            NavItem('Education', onEducation, isActive: activeIndex == 5),
            NavItem('Contact', onContact, isActive: activeIndex == 6),
          ] else
            _MobileMenuButton(onPressed: () => _showMobileMenu(context)),
        ],
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTokens.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTokens.r24),
        ),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.all(AppTokens.s32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MobileNavItem('About', onAbout, context),
            MobileNavItem('Experience', onExperience, context),
            MobileNavItem('Projects', onProjects, context),
            MobileNavItem('Skills', onSkills, context),
            MobileNavItem('Education', onEducation, context),
            MobileNavItem('Contact', onContact, context),
          ],
        ),
      ),
    );
  }
}

class NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  const NavItem(this.label, this.onTap, {super.key, required this.isActive});

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(
            horizontal: AppTokens.s14.w,
            vertical: AppTokens.s8.h,
          ),
          decoration: BoxDecoration(
            color: widget.isActive
                ? AppTokens.accent.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppTokens.r999.r),
            border: Border.all(
              color: widget.isActive
                  ? AppTokens.accent.withValues(alpha: 0.35)
                  : Colors.transparent,
            ),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              color: widget.isActive || _hovered
                  ? AppTokens.textPrimary
                  : AppTokens.textSecondary,
              fontSize: 13.sp,
              fontWeight: widget.isActive ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _MobileMenuButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.menu_rounded, color: AppTokens.textSecondary),
    );
  }
}

class MobileNavItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final BuildContext parentCtx;

  const MobileNavItem(this.label, this.onTap, this.parentCtx, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: GoogleFonts.inter(color: AppTokens.textPrimary, fontSize: 16),
      ),
      onTap: () {
        Navigator.pop(parentCtx);
        onTap();
      },
    );
  }
}
