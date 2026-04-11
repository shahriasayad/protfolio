import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/core/constants/app_tokens.dart';
import '../../viewmodels/portfolio_controller.dart';
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
class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scrollController = ScrollController();
  final _ctrl = Get.find<PortfolioController>();

  // Section keys for scroll-to navigation
  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _educationKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // Hide/show nav on scroll direction
      _ctrl.isNavVisible.value =
          _scrollController.position.userScrollDirection ==
              ScrollDirection.forward ||
          _scrollController.offset < 80;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTokens.bg,
      body: Stack(
        children: [
          // ── Scrollable content ──────────────────────────────
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: AppTokens.s64), // nav clearance
                HeroSection(
                  key: _heroKey,
                  onHire: () => _scrollTo(_contactKey),
                  onProjects: () => _scrollTo(_projectsKey),
                ),
                _divider(),
                AboutSection(key: _aboutKey),
                _divider(),
                SkillsSection(key: _skillsKey),
                _divider(),
                const ToolsSection(),
                _divider(),
                ProjectsSection(key: _projectsKey),
                _divider(),
                EducationSection(key: _educationKey),
                _divider(),
                ExperienceSection(key: _experienceKey),
                _divider(),
                const AchievementsSection(),
                _divider(),
                ContactSection(key: _contactKey),
                const SizedBox(height: AppTokens.s64),
                _footer(),
              ],
            ),
          ),

          // ── Floating nav ────────────────────────────────────
          Obx(
            () => AnimatedSlide(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              offset: _ctrl.isNavVisible.value
                  ? Offset.zero
                  : const Offset(0, -1),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _ctrl.isNavVisible.value ? 1 : 0,
                child: TopNav(
                  onHero: () => _scrollTo(_heroKey),
                  onAbout: () => _scrollTo(_aboutKey),
                  onSkills: () => _scrollTo(_skillsKey),
                  onProjects: () => _scrollTo(_projectsKey),
                  onEducation: () => _scrollTo(_educationKey),
                  onExperience: () => _scrollTo(_experienceKey),
                  onContact: () => _scrollTo(_contactKey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppTokens.s24),
    child: Container(height: 1, color: AppTokens.border),
  );

  Widget _footer() => Center(
    child: Text(
      'Built with Flutter & ♥',
      style: TextStyle(
        color: AppTokens.textMuted,
        fontSize: 13,
        letterSpacing: 0.5,
      ),
    ),
  );
}
