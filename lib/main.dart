// ============================================================
// FLUTTER PORTFOLIO — main.dart
// Modern, minimal, dark-mode portfolio with GetX state mgmt.
// ============================================================
// HOW TO USE:
//   1. Add to pubspec.yaml:
//        dependencies:
//          get:
//          google_fonts:
//   2. Replace data inside PortfolioController with your own.
//   3. flutter run
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

// ────────────────────────────────────────────────────────────
// DESIGN TOKENS — single source of truth for every color,
// spacing, and radius value used across the entire app.
// ────────────────────────────────────────────────────────────
class AppTokens {
  // Colors - Modern gradient palette
  static const bg = Color(0xFF05080F); // deep navy-black
  static const surface = Color(0xFF0F1419); // slightly lighter for depth
  static const surfaceAlt = Color(0xFF1A202D); // elevated surface
  static const border = Color(0xFF2D3748); // more visible borders
  static const textPrimary = Color(0xFFF7FAFC);
  static const textSecondary = Color(0xFF9CA3AF);
  static const textMuted = Color(0xFF6B7280);

  // Primary accent - vibrant cyan-green
  static const accent = Color(0xFF06D6A0); // brighter, more vibrant
  static const accentDim = Color(0xFF0D4D37); // darker for depth

  // Secondary accents for variety
  static const accentPurple = Color(0xFF9F7AEA); // purple
  static const accentBlue = Color(0xFF5B9FFF); // bright blue
  static const accentOrange = Color(0xFFFF8C5A); // warm orange
  static const accentPink = Color(0xFFFF6B9D); // vibrant pink

  // Spacing scale
  static const s4 = 4.0;
  static const s8 = 8.0;
  static const s12 = 12.0;
  static const s16 = 16.0;
  static const s24 = 24.0;
  static const s32 = 32.0;
  static const s48 = 48.0;
  static const s64 = 64.0;
  static const s96 = 96.0;

  // Radii
  static const r8 = 8.0;
  static const r12 = 12.0;
  static const r16 = 16.0;
  static const r24 = 24.0;
  static const r999 = 999.0;

  // Max content width - better for web
  static const maxWidth = 1200.0;
  static const maxWidthNarrow = 900.0;
}

// ────────────────────────────────────────────────────────────
// DATA MODELS
// ────────────────────────────────────────────────────────────

class ProjectModel {
  final String title;
  final String description;
  final List<String> tech;
  final String link;
  final String emoji;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.tech,
    required this.link,
    required this.emoji,
  });
}

class ExperienceModel {
  final String role;
  final String company;
  final String period;
  final String description;

  const ExperienceModel({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
  });
}

class EducationModel {
  final String degree;
  final String school;
  final String period;
  final String field;
  final String description;

  const EducationModel({
    required this.degree,
    required this.school,
    required this.period,
    required this.field,
    required this.description,
  });
}

class SocialLink {
  final String label;
  final String url;
  final IconData icon;

  const SocialLink({
    required this.label,
    required this.url,
    required this.icon,
  });
}

class SkillModel {
  final String name;
  final double proficiency; // 0.0 to 1.0
  final String category; // 'Frontend', 'Backend', 'Tools', etc.
  final IconData? icon;

  const SkillModel({
    required this.name,
    required this.proficiency,
    required this.category,
    this.icon,
  });
}

// ────────────────────────────────────────────────────────────
// PORTFOLIO CONTROLLER — all content lives here.
// Replace fields with your own data; UI updates automatically.
// ────────────────────────────────────────────────────────────
class PortfolioController extends GetxController {
  // ── Tools ───────────────────────────────────────────────
  final tools = [
    {'name': 'VS Code', 'icon': 'icons/vscode.png', 'color': Color(0xFF007ACC)},
    {
      'name': 'Android Studio',
      'icon': 'icons/androidstudio.png',
      'color': Color(0xFF3DDC84),
    },
    {
      'name': 'IntelliJ IDEA',
      'icon': 'icons/intellijidea.png',
      'color': Color(0xFFEE5A52),
    },
    {'name': 'GitHub', 'icon': 'icons/github.png', 'color': Color(0xFFFFFFFF)},
    {
      'name': 'Postman',
      'icon': 'icons/postman.png',
      'color': Color(0xFFFF6C37),
    },
    {
      'name': 'Swagger',
      'icon': 'icons/swagger.png',
      'color': Color(0xFF85EA2D),
    },
  ];
  // ── Personal info ──────────────────────────────────────────
  final name = 'Shahria Sayad'.obs;
  final title = 'Flutter Developer'.obs;
  final imageUrl = 'assets/images/profile.jpg'; // Local asset image
  final intro =
      'I craft fast, beautiful cross-platform apps\nthat feel native everywhere.'
          .obs;
  final bio =
      '''
I'm a Flutter developer with 4+ years of experience building production apps for 
startups and scale-ups. I care deeply about performance, clean architecture, and 
pixel-perfect UI that users actually enjoy.

When I'm not shipping features, you'll find me contributing to open-source, 
writing about Dart internals, or hiking somewhere without cell service.
'''
          .obs;

  final email = 'shahriasayad9@gmail.com'.obs;

  // ── Skills ─────────────────────────────────────────────────
  final skills = <SkillModel>[
    // Frontend
    SkillModel(
      name: 'Flutter',
      proficiency: 0.92,
      category: 'Frontend',
      icon: Icons.flutter_dash,
    ),
    SkillModel(
      name: 'Dart',
      proficiency: 0.90,
      category: 'Frontend',
      icon: Icons.code,
    ),
    SkillModel(
      name: 'Python',
      proficiency: 0.50,
      category: 'Frontend',
      icon: Icons.terminal,
    ),
    // State Management
    SkillModel(
      name: 'GetX',
      proficiency: 0.95,
      category: 'State Management',
      icon: Icons.settings,
    ),
    // Backend & Data
    SkillModel(
      name: 'Firebase',
      proficiency: 0.80,
      category: 'Backend',
      icon: Icons.cloud,
    ),
    SkillModel(
      name: 'REST API',
      proficiency: 0.85,
      category: 'Backend',
      icon: Icons.api,
    ),
    SkillModel(
      name: 'Hive',
      proficiency: 0.80,
      category: 'Backend',
      icon: Icons.storage,
    ),
    SkillModel(
      name: 'Shared Preference',
      proficiency: 0.88,
      category: 'Backend',
      icon: Icons.save,
    ),
    // DevOps & Tools
    SkillModel(
      name: 'Git',
      proficiency: 0.95,
      category: 'DevOps',
      icon: Icons.merge_type,
    ),
  ];

  // ── Projects ───────────────────────────────────────────────
  final projects = <ProjectModel>[
    ProjectModel(
      emoji: '🛒',
      title: 'ShopFlow',
      description:
          'A full-featured e-commerce app with real-time inventory, '
          'Stripe payments, and animated product carousels. Reached 50k+ MAU.',
      tech: ['Flutter', 'Firebase', 'Stripe', 'GetX'],
      link: 'https://github.com/example/shopflow',
    ),
    ProjectModel(
      emoji: '🧘',
      title: 'Stillness',
      description:
          'Mindfulness app with guided meditations, breathing exercises, '
          'and sleep stories. Featured on the App Store in 12 countries.',
      tech: ['Flutter', 'Dart', 'Riverpod', 'Supabase'],
      link: 'https://github.com/example/stillness',
    ),
    ProjectModel(
      emoji: '📊',
      title: 'DashKit',
      description:
          'A reusable Flutter dashboard component library with 30+ '
          'charts, tables, and KPI widgets. 600+ GitHub stars.',
      tech: ['Flutter', 'fl_chart', 'pub.dev'],
      link: 'https://github.com/example/dashkit',
    ),
    ProjectModel(
      emoji: '🤖',
      title: 'Jarvis CLI',
      description:
          'A command-line dev tool that scaffolds Flutter projects with '
          'opinionated architecture, linting, and CI templates in seconds.',
      tech: ['Dart', 'CLI', 'GitHub Actions'],
      link: 'https://github.com/example/jarvis-cli',
    ),
  ];

  // ── Experience ─────────────────────────────────────────────
  final experience = <ExperienceModel>[
    ExperienceModel(
      role: 'Senior Flutter Developer',
      company: 'Luminary Labs',
      period: '2022 – Present',
      description:
          'Led mobile team of 5, shipped 3 major app versions. '
          'Reduced build times by 40% via modular architecture.',
    ),
    ExperienceModel(
      role: 'Flutter Developer',
      company: 'Kite Agency',
      period: '2020 – 2022',
      description:
          'Built 8 client apps across fintech, health, and retail. '
          'Introduced automated testing culture from scratch.',
    ),
    ExperienceModel(
      role: 'Mobile Developer Intern',
      company: 'Nexora',
      period: '2019 – 2020',
      description:
          'Started with React Native, migrated flagship app to Flutter. '
          'Maintained Dart packages published on pub.dev.',
    ),
  ];

  // ── Education ──────────────────────────────────────────────
  final education = <EducationModel>[
    EducationModel(
      degree: 'Bachelor of Science (BSc)',
      school: 'Uttara University (UU)',
      period: 'Expected Graduation: 2028',
      field: 'Computer Science and Engineering',
      description:
          'Currently pursuing a Bachelor\'s degree in CSE with focus on software development and emerging technologies.',
    ),
    EducationModel(
      degree: 'Diploma in Engineering',
      school: 'Brahmanbaria Polytechnic Institute (BBPI)',
      period: '2021 – 2024',
      field: 'Computer Science and Engineering',
      description:
          'Completed diploma studies in CSE with hands-on experience in web and application development.',
    ),
    EducationModel(
      degree: 'Secondary School Certificate (SSC)',
      school: 'Barura High School and College (BHSC)',
      period: '2016 – 2020',
      field: 'Science',
      description:
          'Completed secondary education with strong focus on science and mathematics.',
    ),
  ];

  // ── Social Links ───────────────────────────────────────────
  final socials = <SocialLink>[
    SocialLink(
      label: 'GitHub',
      url: 'https://github.com/shahriasayad',
      icon: Icons.code,
    ),
    SocialLink(
      label: 'LinkedIn',
      url: 'https://www.linkedin.com/in/shahria-sayad-9236a1308/',
      icon: Icons.link,
    ),
    SocialLink(
      label: 'Email',
      url: 'mailto:shahriasayad9@gmail.com',
      icon: Icons.email,
    ),
  ];

  // ── Reactive state ─────────────────────────────────────────
  final activeSection = 0.obs; // tracks nav highlight
  final isNavVisible = true.obs;
}

// ────────────────────────────────────────────────────────────
// APP ROOT
// ────────────────────────────────────────────────────────────
class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Register controller globally
    Get.put(PortfolioController());

    return GetMaterialApp(
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

// ────────────────────────────────────────────────────────────
// PORTFOLIO PAGE — orchestrates all sections in a scroll view
// ────────────────────────────────────────────────────────────
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
                const SizedBox(height: AppTokens.s96), // nav clearance
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
      style: GoogleFonts.inter(
        color: AppTokens.textMuted,
        fontSize: 13,
        letterSpacing: 0.5,
      ),
    ),
  );
}

// ────────────────────────────────────────────────────────────
// TOP NAV
// ────────────────────────────────────────────────────────────
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
      color: AppTokens.bg.withOpacity(0.85),
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
                _NavItem('About', onAbout),
                _NavItem('Skills', onSkills),
                _NavItem('Projects', onProjects),
                _NavItem('Education', onEducation),
                _NavItem('Experience', onExperience),
                _NavItem('Contact', onContact),
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
            _MobileNavItem('About', onAbout, context),
            _MobileNavItem('Skills', onSkills, context),
            _MobileNavItem('Projects', onProjects, context),
            _MobileNavItem('Education', onEducation, context),
            _MobileNavItem('Experience', onExperience, context),
            _MobileNavItem('Contact', onContact, context),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavItem(this.label, this.onTap);

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
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

class _MobileNavItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final BuildContext parentCtx;
  const _MobileNavItem(this.label, this.onTap, this.parentCtx);

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

// ────────────────────────────────────────────────────────────
// SECTION WRAPPER — consistent max-width + padding
// ────────────────────────────────────────────────────────────
class SectionWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const SectionWrapper({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppTokens.maxWidth),
        child: Padding(
          padding:
              padding ??
              const EdgeInsets.symmetric(
                horizontal: AppTokens.s24,
                vertical: AppTokens.s96,
              ),
          child: child,
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────
// HERO SECTION
// ────────────────────────────────────────────────────────────
class HeroSection extends StatefulWidget {
  final VoidCallback onHire;
  final VoidCallback onProjects;

  const HeroSection({
    super.key,
    required this.onHire,
    required this.onProjects,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ac;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  final _ctrl = Get.find<PortfolioController>();

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fade = CurvedAnimation(
      parent: _ac,
      curve: const Interval(0, 0.7, curve: Curves.easeOut),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ac, curve: Curves.easeOutCubic));
    _ac.forward();
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final isMobile = MediaQuery.of(context).size.width < 640;

    return SectionWrapper(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppTokens.s24 : AppTokens.s24,
        vertical: isMobile ? AppTokens.s64 : AppTokens.s96,
      ),
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left: Text content
                    Flexible(flex: 1, child: _HeroTextContent(_ctrl, widget)),
                    const SizedBox(width: AppTokens.s96),
                    // Right: Image
                    Flexible(flex: 1, child: _HeroImage(_ctrl)),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image first on mobile
                    if (!isMobile) _HeroImage(_ctrl),
                    if (!isMobile) const SizedBox(height: AppTokens.s64),
                    // Text content
                    _HeroTextContent(_ctrl, widget),
                    if (isMobile) const SizedBox(height: AppTokens.s48),
                    if (isMobile) Center(child: _HeroImage(_ctrl)),
                  ],
                ),
        ),
      ),
    );
  }
}

class _HeroImage extends StatefulWidget {
  final PortfolioController ctrl;
  const _HeroImage(this.ctrl);

  @override
  State<_HeroImage> createState() => _HeroImageState();
}

class _HeroImageState extends State<_HeroImage>
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
              color: AppTokens.accent.withOpacity(0.2),
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
                  color: AppTokens.accent.withOpacity(0.3),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroTextContent extends StatelessWidget {
  final PortfolioController ctrl;
  final HeroSection widget;

  const _HeroTextContent(this.ctrl, this.widget);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 640;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name with animated gradient
        Obx(
          () => AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              ColorizeAnimatedText(
                ctrl.name.value,
                textStyle: GoogleFonts.spaceGrotesk(
                  fontSize: isMobile ? 48 : 64,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                  letterSpacing: -1.5,
                ),
                colors: [
                  AppTokens.accent,
                  AppTokens.accentBlue,
                  AppTokens.accentPurple,
                  AppTokens.accentPink,
                ],
                speed: const Duration(milliseconds: 400),
              ),
            ],
            isRepeatingAnimation: true,
            pause: const Duration(milliseconds: 1200),
            displayFullTextOnTap: true,
          ),
        ),
        const SizedBox(height: AppTokens.s16),

        // Title with accent
        Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTokens.s16,
              vertical: AppTokens.s8,
            ),
            decoration: BoxDecoration(
              color: AppTokens.accent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(AppTokens.r12),
              border: Border.all(color: AppTokens.accent.withOpacity(0.3)),
            ),
            child: Text(
              ctrl.title.value,
              style: GoogleFonts.inter(
                color: AppTokens.accent,
                fontSize: isMobile ? 16 : 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppTokens.s32),

        // Intro/Bio with typing animation
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Obx(
            () => AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [
                TypewriterAnimatedText(
                  ctrl.intro.value,
                  textStyle: GoogleFonts.inter(
                    color: AppTokens.textSecondary,
                    fontSize: isMobile ? 16 : 18,
                    height: 1.8,
                    fontWeight: FontWeight.w400,
                  ),
                  speed: const Duration(milliseconds: 38),
                  cursor: '|',
                ),
              ],
              totalRepeatCount: 1,
              displayFullTextOnTap: true,
              pause: const Duration(milliseconds: 800),
            ),
          ),
        ),
        const SizedBox(height: AppTokens.s48),

        // CTA Buttons
        Wrap(
          spacing: AppTokens.s16,
          runSpacing: AppTokens.s16,
          children: [
            _PrimaryButton(label: 'View My Work', onTap: widget.onProjects),
            _SecondaryButton(label: 'Get In Touch', onTap: widget.onHire),
          ],
        ),
      ],
    );
  }
}

// Primary CTA
class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.onTap});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
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
            horizontal: AppTokens.s24,
            vertical: AppTokens.s16,
          ),
          decoration: BoxDecoration(
            color: _hovered
                ? AppTokens.accent.withOpacity(0.9)
                : AppTokens.accent,
            borderRadius: BorderRadius.circular(AppTokens.r12),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              color: AppTokens.bg,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

// Ghost CTA
class _GhostButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _GhostButton({required this.label, required this.onTap});

  @override
  State<_GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<_GhostButton> {
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
            horizontal: AppTokens.s24,
            vertical: AppTokens.s16,
          ),
          decoration: BoxDecoration(
            color: _hovered ? AppTokens.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(AppTokens.r12),
            border: Border.all(color: AppTokens.border),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              color: AppTokens.textPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

// Secondary button
class _SecondaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _SecondaryButton({required this.label, required this.onTap});

  @override
  State<_SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<_SecondaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.s32,
            vertical: AppTokens.s16,
          ),
          decoration: BoxDecoration(
            color: _hovered ? AppTokens.surfaceAlt : AppTokens.surface,
            borderRadius: BorderRadius.circular(AppTokens.r12),
            border: Border.all(
              color: _hovered
                  ? AppTokens.accent.withOpacity(0.5)
                  : AppTokens.border.withOpacity(0.5),
              width: 2,
            ),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              color: _hovered ? AppTokens.accent : AppTokens.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────
// ABOUT SECTION
// ────────────────────────────────────────────────────────────
// ABOUT SECTION
// ────────────────────────────────────────────────────────────
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return SectionWrapper(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(label: 'About'),
          const SizedBox(height: AppTokens.s48),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Obx(() => _AboutText(bio: ctrl.bio.value)),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────
// SKILLS SECTION
// ────────────────────────────────────────────────────────────
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    // Group skills by category
    final Map<String, List<SkillModel>> grouped = {};
    for (final skill in ctrl.skills) {
      grouped.putIfAbsent(skill.category, () => []).add(skill);
    }

    return SectionWrapper(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(label: 'Skills'),
          const SizedBox(height: AppTokens.s16),
          Text(
            'A snapshot of my technical strengths',
            style: GoogleFonts.inter(
              color: AppTokens.textMuted,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: AppTokens.s48),
          ...grouped.entries.map(
            (entry) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: AppTokens.s16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTokens.s12,
                      vertical: AppTokens.s4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTokens.surfaceAlt,
                      borderRadius: BorderRadius.circular(AppTokens.r8),
                    ),
                    child: Text(
                      entry.key,
                      style: GoogleFonts.inter(
                        color: AppTokens.accent,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                ...entry.value.map(
                  (skill) => Padding(
                    padding: const EdgeInsets.only(bottom: AppTokens.s24),
                    child: _SkillCard(skill: skill),
                  ),
                ),
                const SizedBox(height: AppTokens.s32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────
// TOOLS SECTION
// ────────────────────────────────────────────────────────────
class ToolsSection extends StatelessWidget {
  const ToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();
    final isWide = MediaQuery.of(context).size.width > 700;
    return SectionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(label: 'Tools'),
          const SizedBox(height: AppTokens.s48),
          LayoutBuilder(
            builder: (context, constraints) {
              final cols = isWide ? 4 : 2;
              final items = ctrl.tools;
              final rows = (items.length / cols).ceil();
              return Column(
                children: List.generate(rows, (r) {
                  return Row(
                    children: List.generate(cols, (c) {
                      final idx = r * cols + c;
                      if (idx >= items.length)
                        return Expanded(child: Container());
                      final tool = items[idx];
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: c < cols - 1 ? AppTokens.s16 : 0,
                            bottom: AppTokens.s24,
                          ),
                          child: _ToolCard(
                            name: tool['name'] as String,
                            icon: tool['icon'] as String,
                            color: tool['color'] as Color,
                          ),
                        ),
                      );
                    }),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ToolCard extends StatefulWidget {
  final String name;
  final String icon;
  final Color color;
  const _ToolCard({
    required this.name,
    required this.icon,
    required this.color,
  });

  @override
  State<_ToolCard> createState() => _ToolCardState();
}

class _ToolCardState extends State<_ToolCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTokens.s24,
          vertical: AppTokens.s32,
        ),
        decoration: BoxDecoration(
          color: _hovered ? widget.color.withOpacity(0.08) : AppTokens.surface,
          borderRadius: BorderRadius.circular(AppTokens.r16),
          border: Border.all(
            color: _hovered ? widget.color.withOpacity(0.4) : AppTokens.border,
            width: 2,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: widget.color.withOpacity(0.13),
                    blurRadius: 24,
                    spreadRadius: 0,
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.18),
                borderRadius: BorderRadius.circular(AppTokens.r999),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(widget.icon, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: AppTokens.s16),
            Text(
              widget.name,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: AppTokens.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 15,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Card for each skill with icon, bar, and animation
class _SkillCard extends StatefulWidget {
  final SkillModel skill;
  const _SkillCard({required this.skill});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ac;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = CurvedAnimation(parent: _ac, curve: Curves.easeOutCubic);
    _ac.forward();
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: Container(
        decoration: BoxDecoration(
          color: AppTokens.surface,
          borderRadius: BorderRadius.circular(AppTokens.r16),
          border: Border.all(color: AppTokens.border.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: AppTokens.accent.withOpacity(0.06),
              blurRadius: 16,
              spreadRadius: 0,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTokens.s24,
          vertical: AppTokens.s16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppTokens.surfaceAlt,
                borderRadius: BorderRadius.circular(AppTokens.r999),
                border: Border.all(color: AppTokens.border.withOpacity(0.4)),
              ),
              child: Icon(
                widget.skill.icon ?? Icons.star,
                color: AppTokens.accent,
                size: 22,
              ),
            ),
            const SizedBox(width: AppTokens.s24),
            Expanded(child: _SkillBar(skill: widget.skill)),
          ],
        ),
      ),
    );
  }
}

class _AboutText extends StatelessWidget {
  final String bio;
  const _AboutText({required this.bio});

  @override
  Widget build(BuildContext context) {
    return Text(
      bio.trim(),
      style: GoogleFonts.inter(
        color: AppTokens.textSecondary,
        fontSize: 16,
        height: 1.8,
      ),
    );
  }
}

// Skill bar with proficiency visualization
class _SkillBar extends StatefulWidget {
  final SkillModel skill;
  const _SkillBar({required this.skill});

  @override
  State<_SkillBar> createState() => _SkillBarState();
}

class _SkillBarState extends State<_SkillBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ac;
  late Animation<double> _widthAnim;

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _widthAnim = Tween<double>(
      begin: 0,
      end: widget.skill.proficiency,
    ).animate(CurvedAnimation(parent: _ac, curve: Curves.easeOutCubic));
    _ac.forward();
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Frontend':
        return AppTokens.accentBlue;
      case 'State Management':
        return AppTokens.accent;
      case 'Backend':
        return AppTokens.accentPurple;
      case 'DevOps':
        return AppTokens.accentOrange;
      case 'Design':
        return AppTokens.accentPink;
      default:
        return AppTokens.accent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final barColor = _getCategoryColor(widget.skill.category);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.skill.name,
              style: GoogleFonts.inter(
                color: AppTokens.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${(widget.skill.proficiency * 100).toStringAsFixed(0)}%',
              style: GoogleFonts.inter(
                color: barColor,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTokens.s12),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppTokens.r999),
          child: Container(
            height: 14,
            color: AppTokens.border,
            child: AnimatedBuilder(
              animation: _widthAnim,
              builder: (context, _) => Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: _widthAnim.value,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          barColor.withOpacity(0.85),
                          barColor.withOpacity(0.55),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(AppTokens.r999),
                      boxShadow: [
                        BoxShadow(
                          color: barColor.withOpacity(0.25),
                          blurRadius: 16,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String label;
  const _SkillChip({required this.label});

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTokens.s12,
          vertical: AppTokens.s8,
        ),
        decoration: BoxDecoration(
          color: _hovered ? AppTokens.accentDim : AppTokens.surface,
          borderRadius: BorderRadius.circular(AppTokens.r8),
          border: Border.all(
            color: _hovered
                ? AppTokens.accent.withOpacity(0.4)
                : AppTokens.border,
          ),
        ),
        child: Text(
          widget.label,
          style: GoogleFonts.inter(
            color: _hovered ? AppTokens.accent : AppTokens.textSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────
// PROJECTS SECTION
// ────────────────────────────────────────────────────────────
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return SectionWrapper(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(label: 'Projects'),
          const SizedBox(height: AppTokens.s48),

          // Responsive grid
          LayoutBuilder(
            builder: (context, constraints) {
              // Responsive column count
              int cols;
              if (constraints.maxWidth < 600) {
                cols = 1;
              } else if (constraints.maxWidth < 1000) {
                cols = 2;
              } else {
                cols = 3;
              }

              final items = ctrl.projects;
              if (cols > items.length) cols = items.length;
              final rows = (items.length / cols).ceil();

              return Column(
                children: List.generate(rows, (r) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppTokens.s24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(cols, (c) {
                        final idx = r * cols + c;
                        if (idx >= items.length)
                          return Expanded(child: Container());
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: c < cols - 1 ? AppTokens.s16 : 0,
                            ),
                            child: _ProjectCard(project: items[idx]),
                          ),
                        );
                      }),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppTokens.s24),
        decoration: BoxDecoration(
          color: _hovered ? AppTokens.surfaceAlt : AppTokens.surface,
          borderRadius: BorderRadius.circular(AppTokens.r16),
          border: Border.all(
            color: _hovered
                ? AppTokens.accent.withOpacity(0.25)
                : AppTokens.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppTokens.accent.withOpacity(0.05),
                    blurRadius: 40,
                    spreadRadius: 0,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emoji + arrow row
            Row(
              children: [
                Text(p.emoji, style: const TextStyle(fontSize: 28)),
                const Spacer(),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _hovered ? 1 : 0.3,
                  child: Icon(
                    Icons.arrow_outward,
                    color: AppTokens.accent,
                    size: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTokens.s16),

            // Title
            Text(
              p.title,
              style: GoogleFonts.spaceGrotesk(
                color: AppTokens.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: AppTokens.s8),

            // Description
            Text(
              p.description,
              style: GoogleFonts.inter(
                color: AppTokens.textSecondary,
                fontSize: 14,
                height: 1.6,
              ),
            ),
            const SizedBox(height: AppTokens.s16),

            // Tech chips
            Wrap(
              spacing: AppTokens.s4,
              runSpacing: AppTokens.s4,
              children: p.tech
                  .map(
                    (t) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTokens.s8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTokens.bg,
                        borderRadius: BorderRadius.circular(AppTokens.r8),
                        border: Border.all(color: AppTokens.border),
                      ),
                      child: Text(
                        t,
                        style: GoogleFonts.inter(
                          color: AppTokens.textMuted,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────
// EDUCATION SECTION
// ────────────────────────────────────────────────────────────
class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return SectionWrapper(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(label: 'Education'),
          const SizedBox(height: AppTokens.s48),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...ctrl.education.asMap().entries.map(
                (e) => _EducationCard(
                  item: e.value,
                  isLast: e.key == ctrl.education.length - 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EducationCard extends StatefulWidget {
  final EducationModel item;
  final bool isLast;
  const _EducationCard({required this.item, required this.isLast});

  @override
  State<_EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<_EducationCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final edu = widget.item;
    const accentColors = [AppTokens.accentBlue, AppTokens.accentPurple];
    final accentColor =
        accentColors[widget.item.hashCode % accentColors.length];

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: widget.isLast ? 0 : AppTokens.s24),
        padding: const EdgeInsets.all(AppTokens.s24),
        decoration: BoxDecoration(
          color: _hovered ? AppTokens.surfaceAlt : AppTokens.surface,
          borderRadius: BorderRadius.circular(AppTokens.r12),
          border: Border.all(
            color: _hovered ? accentColor.withOpacity(0.4) : AppTokens.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: accentColor.withOpacity(0.1),
                    blurRadius: 24,
                    spreadRadius: 0,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppTokens.s8),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(AppTokens.r8),
                  ),
                  child: Icon(
                    Icons.school_outlined,
                    color: accentColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppTokens.s16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        edu.degree,
                        style: GoogleFonts.spaceGrotesk(
                          color: AppTokens.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        edu.field,
                        style: GoogleFonts.inter(
                          color: accentColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  edu.period,
                  style: GoogleFonts.inter(
                    color: AppTokens.textMuted,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTokens.s16),
            Text(
              edu.school,
              style: GoogleFonts.inter(
                color: AppTokens.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppTokens.s12),
            Text(
              edu.description,
              style: GoogleFonts.inter(
                color: AppTokens.textSecondary,
                fontSize: 13,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────
// EXPERIENCE / TIMELINE SECTION
// ────────────────────────────────────────────────────────────
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return SectionWrapper(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(label: 'Experience'),
          const SizedBox(height: AppTokens.s48),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...ctrl.experience.asMap().entries.map(
                (e) => _TimelineItem(
                  item: e.value,
                  isLast: e.key == ctrl.experience.length - 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatefulWidget {
  final ExperienceModel item;
  final bool isLast;
  const _TimelineItem({required this.item, required this.isLast});

  @override
  State<_TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<_TimelineItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final e = widget.item;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline column
        SizedBox(
          width: 32,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 6),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _hovered ? AppTokens.accent : AppTokens.border,
                  border: Border.all(
                    color: _hovered ? AppTokens.accent : AppTokens.textMuted,
                    width: 2,
                  ),
                ),
              ),
              if (!widget.isLast)
                SizedBox(
                  width: 1,
                  height: AppTokens.s32,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: AppTokens.border,
                  ),
                )
              else
                const SizedBox(height: AppTokens.s32),
            ],
          ),
        ),
        const SizedBox(width: AppTokens.s16),

        // Content
        Expanded(
          child: MouseRegion(
            onEnter: (_) => setState(() => _hovered = true),
            onExit: (_) => setState(() => _hovered = false),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: widget.isLast ? 0 : AppTokens.s32,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        e.role,
                        style: GoogleFonts.spaceGrotesk(
                          color: AppTokens.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        e.period,
                        style: GoogleFonts.inter(
                          color: AppTokens.textMuted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTokens.s4),
                  Text(
                    e.company,
                    style: GoogleFonts.inter(
                      color: AppTokens.accent,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppTokens.s8),
                  Text(
                    e.description,
                    style: GoogleFonts.inter(
                      color: AppTokens.textSecondary,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────
// CONTACT SECTION
// ────────────────────────────────────────────────────────────
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();

    return SectionWrapper(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(label: 'Contact'),
          const SizedBox(height: AppTokens.s48),

          // Big CTA text
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              "Have a project in mind?\nLet's talk.",
              style: GoogleFonts.spaceGrotesk(
                color: AppTokens.textPrimary,
                fontSize: 36,
                fontWeight: FontWeight.w700,
                letterSpacing: -1,
                height: 1.15,
              ),
            ),
          ),
          const SizedBox(height: AppTokens.s32),

          // Email link (clickable)
          _EmailButton(email: ctrl.email.value),
          const SizedBox(height: AppTokens.s32),

          // Social links
          Wrap(
            spacing: AppTokens.s12,
            runSpacing: AppTokens.s12,
            children: ctrl.socials
                .map((s) => _SocialButton(social: s))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _EmailButton extends StatefulWidget {
  final String email;
  const _EmailButton({required this.email});

  @override
  State<_EmailButton> createState() => _EmailButtonState();
}

class _EmailButtonState extends State<_EmailButton> {
  bool _hovered = false;

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(scheme: 'mailto', path: widget.email);
    if (!await launchUrl(emailUri)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not launch email client')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _launchEmail,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: GoogleFonts.inter(
            color: _hovered ? AppTokens.accent : AppTokens.textSecondary,
            fontSize: 16,
            fontWeight: _hovered ? FontWeight.w600 : FontWeight.w400,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.mail_outline,
                color: _hovered ? AppTokens.accent : AppTokens.textSecondary,
                size: 18,
              ),
              const SizedBox(width: AppTokens.s8),
              Text(widget.email),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final SocialLink social;
  const _SocialButton({required this.social});

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(widget.social.url);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch ${widget.social.url}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _launchUrl,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTokens.s16,
            vertical: AppTokens.s12,
          ),
          decoration: BoxDecoration(
            color: _hovered ? AppTokens.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(AppTokens.r12),
            border: Border.all(
              color: _hovered ? AppTokens.border : AppTokens.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.social.icon,
                color: _hovered ? AppTokens.accent : AppTokens.textSecondary,
                size: 16,
              ),
              const SizedBox(width: AppTokens.s8),
              Text(
                widget.social.label,
                style: GoogleFonts.inter(
                  color: _hovered
                      ? AppTokens.textPrimary
                      : AppTokens.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────
// SHARED WIDGETS
// ────────────────────────────────────────────────────────────

/// Subtle uppercase section label with accent underline
class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 16,
          decoration: BoxDecoration(
            color: AppTokens.accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        // const SizedBox(width: AppTokens.s8),
        Text(
          label.toUpperCase(),
          style: GoogleFonts.inter(
            color: AppTokens.textMuted,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
