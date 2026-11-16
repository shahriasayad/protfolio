import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/theme/app_text_styles.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import '../common/hover_builder.dart';

/// Top editorial navigation bar with desktop inline links and mobile sheet drawer.
class TopNav extends StatelessWidget {
  final int activeIndex;
  final VoidCallback onHero;
  final VoidCallback onAbout;
  final VoidCallback onSkills;
  final VoidCallback onProjects;
  final VoidCallback onEducation;
  final VoidCallback onExperience;
  final VoidCallback onContact;

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
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = AppScreenUtil.isDesktopWidth(width);
    final isMobile = AppScreenUtil.isMobileWidth(width);

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppTokens.surfaceGlass,
        border: Border(bottom: BorderSide(color: AppTokens.border)),
      ),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppTokens.maxWidth),
            child: SizedBox(
              height: AppTokens.navHeight,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? AppTokens.s20 : AppTokens.s32,
                ),
                child: Row(
                  children: [
                    _BrandMark(onTap: onHero, showSubtitle: width > 340),
                    const Spacer(),
                    if (isDesktop)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NavItem(
                            'About',
                            onAbout,
                            isActive: activeIndex == 1,
                          ),
                          NavItem(
                            'Experience',
                            onExperience,
                            isActive: activeIndex == 2,
                          ),
                          NavItem(
                            'Projects',
                            onProjects,
                            isActive: activeIndex == 3,
                          ),
                          NavItem(
                            'Skills',
                            onSkills,
                            isActive: activeIndex == 4,
                          ),
                          NavItem(
                            'Education',
                            onEducation,
                            isActive: activeIndex == 5,
                          ),
                          NavItem(
                            'Contact',
                            onContact,
                            isActive: activeIndex == 6,
                          ),
                        ],
                      )
                    else
                      IconButton(
                        tooltip: 'Navigation menu',
                        onPressed: () => _showMobileMenu(context),
                        icon: const Icon(
                          Icons.menu_rounded,
                          color: AppTokens.textPrimary,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppTokens.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTokens.r16),
        ),
        side: BorderSide(color: AppTokens.border),
      ),
      builder: (sheetCtx) => SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.s20,
            vertical: AppTokens.s24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: AppTokens.s12,
                  bottom: AppTokens.s12,
                ),
                child: Text(
                  'NAVIGATE',
                  style: AppTextStyles.mono(
                    fontSize: 11,
                    color: AppTokens.textMuted,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
              MobileNavItem(
                'About',
                onAbout,
                sheetCtx,
                indexLabel: '01',
                isActive: activeIndex == 1,
              ),
              MobileNavItem(
                'Experience',
                onExperience,
                sheetCtx,
                indexLabel: '02',
                isActive: activeIndex == 2,
              ),
              MobileNavItem(
                'Projects',
                onProjects,
                sheetCtx,
                indexLabel: '03',
                isActive: activeIndex == 3,
              ),
              MobileNavItem(
                'Skills',
                onSkills,
                sheetCtx,
                indexLabel: '04',
                isActive: activeIndex == 4,
              ),
              MobileNavItem(
                'Education',
                onEducation,
                sheetCtx,
                indexLabel: '05',
                isActive: activeIndex == 5,
              ),
              MobileNavItem(
                'Contact',
                onContact,
                sheetCtx,
                indexLabel: '06',
                isActive: activeIndex == 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  final VoidCallback onTap;
  final bool showSubtitle;

  const _BrandMark({required this.onTap, required this.showSubtitle});

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      hoverId: 'nav_brand',
      onTap: onTap,
      builder: (context, hovered) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: hovered ? AppTokens.accent : AppTokens.surfaceAlt,
                borderRadius: BorderRadius.circular(AppTokens.r6),
                border: Border.all(
                  color: hovered ? AppTokens.accent : AppTokens.borderStrong,
                ),
              ),
              child: Text(
                'S/',
                style: AppTextStyles.mono(
                  fontSize: 13,
                  color: hovered ? AppTokens.bg : AppTokens.accent,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (showSubtitle) ...[
              const SizedBox(width: AppTokens.s12),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shahria Sayad',
                    style: AppTextStyles.getTextStyle(
                      family: AppFontFamily.display,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppTokens.textPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  Text(
                    'Flutter Developer',
                    style: AppTextStyles.mono(
                      fontSize: 10,
                      color: AppTokens.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}

/// Desktop top-bar navigation link with crisp bottom active underline.
class NavItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  const NavItem(
    this.label,
    this.onTap, {
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      hoverId: 'nav_$label',
      onTap: onTap,
      builder: (context, hovered) {
        final highlight = isActive || hovered;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTokens.s12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: AppTextStyles.body(
                  fontSize: 13,
                  color: highlight
                      ? AppTokens.textPrimary
                      : AppTokens.textSecondary,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: AppTokens.s4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                height: 2,
                width: isActive ? 18 : 0,
                decoration: BoxDecoration(
                  color: AppTokens.accent,
                  borderRadius: BorderRadius.circular(AppTokens.r999),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Mobile drawer navigation row.
class MobileNavItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final BuildContext parentCtx;
  final String indexLabel;
  final bool isActive;

  const MobileNavItem(
    this.label,
    this.onTap,
    this.parentCtx, {
    super.key,
    this.indexLabel = '',
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTokens.r8),
      ),
      tileColor: isActive ? AppTokens.surfaceAlt : Colors.transparent,
      leading: indexLabel.isNotEmpty
          ? Text(
              indexLabel,
              style: AppTextStyles.mono(
                fontSize: 12,
                color: isActive ? AppTokens.accent : AppTokens.textMuted,
              ),
            )
          : null,
      title: Text(
        label,
        style: AppTextStyles.body(
          fontSize: 15,
          color: isActive ? AppTokens.textPrimary : AppTokens.textSecondary,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          height: 1.2,
        ),
      ),
      trailing: isActive
          ? const Icon(Icons.circle, size: 7, color: AppTokens.accent)
          : null,
      onTap: () {
        Navigator.pop(parentCtx);
        onTap();
      },
    );
  }
}
