import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import 'package:my_portfolio/core/utils/app_screen_util.dart';
import '../../viewmodels/portfolio_controller.dart';
import '../widgets/common/portfolio_backdrop.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/skills_section.dart';
import '../sections/tools_section.dart';
import '../sections/projects_section.dart';
import '../sections/education_section.dart';
import '../sections/experience_section.dart';
import '../sections/achievements_section.dart';
import '../sections/contact_section.dart';
import '../widgets/nav/top_nav.dart';

/// Portfolio page - main screen with all sections
class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return Scaffold(
      backgroundColor: AppTokens.bg,
      body: Stack(
        children: [
          const PortfolioBackdrop(),
          Scrollbar(
            controller: ctrl.scrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: ctrl.scrollController,
              child: Column(
                children: [
                  SizedBox(height: AppTokens.s24.h),
                  HeroSection(
                    key: ctrl.heroKey,
                    onHire: () => ctrl.scrollToSection(ctrl.contactKey),
                    onProjects: () => ctrl.scrollToSection(ctrl.projectsKey),
                  ),
                  const _Divider(),
                  AboutSection(key: ctrl.aboutKey),
                  const _Divider(),
                  ExperienceSection(key: ctrl.experienceKey),
                  const _Divider(),
                  ProjectsSection(key: ctrl.projectsKey),
                  const _Divider(),
                  SkillsSection(key: ctrl.skillsKey),
                  const _Divider(),
                  const ToolsSection(),
                  const _Divider(),
                  const AchievementsSection(),
                  const _Divider(),
                  EducationSection(key: ctrl.educationKey),
                  const _Divider(),
                  ContactSection(key: ctrl.contactKey),
                  SizedBox(height: AppTokens.s40.h),
                  const _Footer(),
                ],
              ),
            ),
          ),
          Obx(
            () => AnimatedSlide(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              offset: ctrl.isNavVisible.value
                  ? Offset.zero
                  : const Offset(0, -1),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: ctrl.isNavVisible.value ? 1 : 0,
                child: TopNav(
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
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppTokens.s24.w,
        vertical: AppTokens.s4.h,
      ),
      child: Divider(height: 1, color: AppTokens.border),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Built with Flutter & ♥',
      style: const TextStyle(
        color: AppTokens.textMuted,
        fontSize: 13,
        letterSpacing: 0.5,
      ),
    );
  }
}
