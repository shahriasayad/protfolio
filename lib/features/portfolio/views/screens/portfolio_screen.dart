import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_tokens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/app_screen_util.dart';
import '../../viewmodels/portfolio_controller.dart';
import '../sections/about_section.dart';
import '../sections/achievements_section.dart';
import '../sections/contact_section.dart';
import '../sections/education_section.dart';
import '../sections/experience_section.dart';
import '../sections/hero_section.dart';
import '../sections/live_apps_section.dart';
import '../sections/projects_section.dart';
import '../sections/skills_section.dart';
import '../sections/tools_section.dart';
import '../widgets/common/hover_builder.dart';
import '../widgets/common/portfolio_backdrop.dart';
import '../widgets/nav/top_nav.dart';

/// Main portfolio screen composing all editorial sections and sticky top navigation.
class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();
    final topPadding = AppTokens.navHeight + MediaQuery.paddingOf(context).top;

    return Scaffold(
      backgroundColor: AppTokens.bg,
      body: Stack(
        children: [
          const RepaintBoundary(child: PortfolioBackdrop()),
          Scrollbar(
            controller: ctrl.scrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: ctrl.scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: topPadding),
                  RepaintBoundary(
                    child: HeroSection(
                      key: ctrl.heroKey,
                      onHire: () => ctrl.scrollToSection(ctrl.contactKey),
                      onProjects: () => ctrl.scrollToSection(ctrl.projectsKey),
                    ),
                  ),
                  RepaintBoundary(child: AboutSection(key: ctrl.aboutKey)),
                  RepaintBoundary(
                    child: ExperienceSection(key: ctrl.experienceKey),
                  ),
                  const RepaintBoundary(child: LiveAppsSection()),
                  RepaintBoundary(
                    child: ProjectsSection(key: ctrl.projectsKey),
                  ),
                  RepaintBoundary(child: SkillsSection(key: ctrl.skillsKey)),
                  const RepaintBoundary(child: ToolsSection()),
                  const RepaintBoundary(child: AchievementsSection()),
                  RepaintBoundary(
                    child: EducationSection(key: ctrl.educationKey),
                  ),
                  RepaintBoundary(child: ContactSection(key: ctrl.contactKey)),
                  RepaintBoundary(
                    child: _Footer(
                      onBackToTop: () => ctrl.scrollToSection(ctrl.heroKey),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Obx(
              () => TopNav(
                activeIndex: ctrl.activeSectionIndex.value,
                onHero: () => ctrl.scrollToSection(ctrl.heroKey),
                onAbout: () => ctrl.scrollToSection(ctrl.aboutKey),
                onSkills: () => ctrl.scrollToSection(ctrl.skillsKey),
                onProjects: () => ctrl.scrollToSection(ctrl.projectsKey),
                onEducation: () => ctrl.scrollToSection(ctrl.educationKey),
                onExperience: () => ctrl.scrollToSection(ctrl.experienceKey),
                onContact: () => ctrl.scrollToSection(ctrl.contactKey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onBackToTop;

  const _Footer({required this.onBackToTop});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = AppScreenUtil.isMobileWidth(width);

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppTokens.bg,
        border: Border(top: BorderSide(color: AppTokens.border)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppTokens.maxWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? AppTokens.s20 : AppTokens.s32,
              vertical: AppTokens.s24,
            ),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shahria Sayad  ·  Built with Flutter',
                        style: AppTextStyles.mono(
                          fontSize: 12,
                          color: AppTokens.textMuted,
                        ),
                      ),
                      const SizedBox(height: AppTokens.s12),
                      _BackToTopAction(onTap: onBackToTop),
                    ],
                  )
                : Row(
                    children: [
                      Text(
                        'Shahria Sayad  ·  Built with Flutter',
                        style: AppTextStyles.mono(
                          fontSize: 12,
                          color: AppTokens.textMuted,
                        ),
                      ),
                      const Spacer(),
                      _BackToTopAction(onTap: onBackToTop),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _BackToTopAction extends StatelessWidget {
  final VoidCallback onTap;

  const _BackToTopAction({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      hoverId: 'footer_top',
      onTap: onTap,
      builder: (context, hovered) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Back to top',
              style: AppTextStyles.mono(
                fontSize: 12,
                color: hovered ? AppTokens.accent : AppTokens.textSecondary,
              ),
            ),
            const SizedBox(width: AppTokens.s6),
            Icon(
              Icons.north_rounded,
              size: 14,
              color: hovered ? AppTokens.accent : AppTokens.textMuted,
            ),
          ],
        );
      },
    );
  }
}
