import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';

/// Top navigation bar
class TopNav extends StatelessWidget {
  final VoidCallback onHero,
      onAbout,
      onSkills,
      onProjects,
      onEducation,
      onExperience,
      onContact;

  const TopNav({
    super.key,
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
    final isWide = MediaQuery.of(context).size.width > 640;
    return Container(
      color: AppTokens.bg.withValues(alpha: 0.85),
      child: ClipRect(
        child: Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppTokens.border)),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.s24,
            vertical: AppTokens.s16,
          ),
          child: Row(
            children: [
              // Logo / name
              GestureDetector(
                onTap: onHero,
                child: Text(
                  'SS.',
                  style: GoogleFonts.spaceGrotesk(
                    color: AppTokens.accent,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
              const Spacer(),
              if (isWide) ...[
                NavItem('About', onAbout),
                NavItem('Skills', onSkills),
                NavItem('Projects', onProjects),
                NavItem('Education', onEducation),
                NavItem('Experience', onExperience),
                NavItem('Contact', onContact),
              ] else
                IconButton(
                  icon: const Icon(Icons.menu, color: AppTokens.textSecondary),
                  onPressed: () => _showMobileMenu(context),
                ),
            ],
          ),
        ),
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
        padding: const EdgeInsets.all(AppTokens.s32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MobileNavItem('About', onAbout, context),
            MobileNavItem('Skills', onSkills, context),
            MobileNavItem('Projects', onProjects, context),
            MobileNavItem('Education', onEducation, context),
            MobileNavItem('Experience', onExperience, context),
            MobileNavItem('Contact', onContact, context),
          ],
        ),
      ),
    );
  }
}

/// Desktop nav item
class NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const NavItem(this.label, this.onTap, {super.key});

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
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.s12,
            vertical: AppTokens.s8,
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              color: _hovered ? AppTokens.textPrimary : AppTokens.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

/// Mobile nav item
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
