import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/app_tokens.dart';
import '../models/project_model.dart';
import '../models/experience_model.dart';
import '../models/achievement_model.dart';
import '../models/education_model.dart';
import '../models/skill_model.dart';
import '../models/social_link_model.dart';
import '../models/portfolio_stat_model.dart';
import '../models/live_app_model.dart';
import '../../../core/utils/icon_color_extractor.dart';
import '../../../core/constants/asset_paths.dart';

/// PortfolioController - ViewModel managing all portfolio data and state
class PortfolioController extends GetxController {
  final scrollController = ScrollController();

  final heroKey = GlobalKey();
  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  final projectsKey = GlobalKey();
  final educationKey = GlobalKey();
  final experienceKey = GlobalKey();
  final contactKey = GlobalKey();

  final contactFormKey = GlobalKey<FormState>();
  final contactEmailController = TextEditingController();
  final contactMessageController = TextEditingController();

  final isContactSubmitting = false.obs;
  final skillPaletteReady = false.obs;
  final activeSectionIndex = 0.obs;

  // ── Tools ───────────────────────────────────────────────
  final tools = <Map<String, Object>>[
    {'name': 'VS Code', 'icon': IconPaths.vsCode, 'color': Color(0xFF007ACC)},
    {
      'name': 'Android Studio',
      'icon': IconPaths.androidStudio,
      'color': Color(0xFF3DDC84),
    },
    {
      'name': 'IntelliJ IDEA',
      'icon': IconPaths.intellijIdea,
      'color': Color(0xFFEE5A52),
    },
    {'name': 'GitHub', 'icon': IconPaths.github, 'color': Color(0xFFFFFFFF)},
    {'name': 'Figma', 'icon': IconPaths.figma, 'color': Color(0xFFF24E1E)},
    {'name': 'Postman', 'icon': IconPaths.postman, 'color': Color(0xFFFF6C37)},
    {'name': 'Swagger', 'icon': IconPaths.swagger, 'color': Color(0xFF85EA2D)},
  ];

  // ── Personal info ──────────────────────────────────────────
  final name = 'Shahria Sayad'.obs;
  final title = 'Flutter Developer'.obs;
  final imageUrl = ImagePaths.profile2;

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
  final brandHeadline =
      'I design and build Flutter products with a sharper point of view.';
  final brandSummary =
      'Product-minded mobile work shaped around clarity, speed, and memorable user experience. I build interfaces that feel designed, not assembled.';
  final availabilityNote =
      'Available for selective freelance work and product teams that care about detail.';

  final heroStats = const <PortfolioStatModel>[
    PortfolioStatModel(
      value: '4+',
      label: 'Years building',
      detail: 'Production Flutter work across apps and features.',
      icon: Icons.timer_outlined,
      accent: AppTokens.accentBlue,
    ),
    PortfolioStatModel(
      value: '9',
      label: 'Core tools',
      detail: 'A focused stack for shipping polished mobile products.',
      icon: Icons.grid_view_rounded,
      accent: AppTokens.accent,
    ),
    PortfolioStatModel(
      value: '6+',
      label: 'Featured projects',
      detail: 'Case studies that show range, craft, and delivery.',
      icon: Icons.auto_awesome_outlined,
      accent: AppTokens.accentPink,
    ),
  ];

  // ── Skills ─────────────────────────────────────────────────
  final skills = <SkillModel>[
    // Frontend
    SkillModel(
      name: 'Flutter',
      proficiency: 0.92,
      category: 'Frontend',
      icon: Icons.flutter_dash,
      iconPath: IconPaths.flutter,
    ),
    SkillModel(
      name: 'Dart',
      proficiency: 0.90,
      category: 'Frontend',
      icon: Icons.code,
      iconPath: IconPaths.dart,
    ),
    // State Management
    SkillModel(
      name: 'GetX',
      proficiency: 0.95,
      category: 'State Management',
      icon: Icons.settings,
      iconPath: IconPaths.getx,
    ),
    // Backend & Data
    SkillModel(
      name: 'Python',
      proficiency: 0.50,
      category: 'Backend',
      icon: Icons.terminal,
      iconPath: IconPaths.python,
    ),
    SkillModel(
      name: 'Socket.io',
      proficiency: 0.75,
      category: 'Backend',
      icon: Icons.sync,
      iconPath: IconPaths.socketIo,
    ),
    SkillModel(
      name: 'Firebase',
      proficiency: 0.80,
      category: 'Backend',
      icon: Icons.cloud,
      iconPath: IconPaths.firebase,
    ),
    SkillModel(
      name: 'REST API',
      proficiency: 0.85,
      category: 'Backend',
      icon: Icons.api,
      iconPath: IconPaths.swagger,
    ),
    SkillModel(
      name: 'Hive',
      proficiency: 0.80,
      category: 'Local Storage',
      icon: Icons.storage,
      iconPath: IconPaths.hive,
    ),
    SkillModel(
      name: 'Shared Preference',
      proficiency: 0.88,
      category: 'Local Storage',
      icon: Icons.save,
      iconPath: IconPaths.sharedPreferences,
    ),
    // DevOps & Tools
    SkillModel(
      name: 'Git',
      proficiency: 0.95,
      category: 'DevOps',
      icon: Icons.merge_type,
      iconPath: IconPaths.git,
    ),
    SkillModel(
      name: 'GitLab',
      proficiency: 0.85,
      category: 'DevOps',
      icon: Icons.code,
      iconPath: IconPaths.gitlab,
    ),
  ];

  // ── Live Apps ──────────────────────────────────────────────
  final liveApps = const <LiveAppModel>[
    LiveAppModel(
      title: 'Taco Client',
      description: 'Ride & parcel booking app with real-time tracking.',
      features: [
        'Ride & parcel booking',
        'Real-time GPS tracking',
        'Fare bidding/negotiation',
        'Wallet & payments',
        'Chat & support',
      ],
      coverImagePath: ImagePaths.tacoClientCover,
      testFlightLink: 'https://testflight.apple.com/join/qtw85aeg',
    ),
    LiveAppModel(
      title: 'Taco Conductor',
      description: 'Driver companion app for ride management.',
      features: [
        'Ride & parcel requests',
        'Real-time bidding',
        'Navigation & trip tracking',
        'Earnings & wallet',
        'Vehicle/profile management',
      ],
      coverImagePath: ImagePaths.tacoConductorCover,
      testFlightLink: 'https://testflight.apple.com/join/ap6qyAFS',
    ),
    LiveAppModel(
      title: 'Florida Yacht Trader',
      description:
          'A comprehensive platform for marine enthusiasts to discover, search, and purchase yachts and boats.',
      features: [
        'Comprehensive Listings',
        'Florida Yacht Trader Integration',
        'Advanced Search Capability',
        'AI-Powered Chat',
        'Nautical Blog & Resources',
      ],
      coverImagePath: ImagePaths.floridaYachtTraderCover,
      appStoreLink:
          'https://apps.apple.com/us/app/florida-yacht-trader/id6769546384',
      playStoreLink:
          'https://play.google.com/store/apps/details?id=com.floridayachttrader.diaz',
    ),
  ];

  final techIntegrations = const [
    {
      'category': 'Framework & Architecture',
      'details': 'Flutter, Dart, GetX (State Management & DI)',
    },
    {
      'category': 'Location & Mapping',
      'details': 'Google Maps API (Live Tracking, Routing, Places API)',
    },
    {
      'category': 'Backend Services',
      'details': 'Firebase (Push Notifications, Authentication) & RESTful APIs',
    },
    {
      'category': 'Real-Time Infrastructure',
      'details':
          'WebSockets (Socket.IO) for live bidding, chat, and driver tracking',
    },
  ];

  // ── Projects ───────────────────────────────────────────────
  final projects = <ProjectModel>[
    ProjectModel(
      emoji: '🍔',
      title: 'Bite Go',
      description:
          'A comprehensive, dual-sided food delivery platform featuring dedicated experiences for both customers and delivery partners.',
      tech: ['Flutter', 'GetX', 'Local State Management'],
      link: 'https://github.com/shahriasayad/bite_go',
      impact:
          'Dual-role architecture, complete customer journey, rider dashboard',
      coverImagePath: ImagePaths.biteGoCover,
    ),
    ProjectModel(
      emoji: '🩺',
      title: 'Care Bridge',
      description:
          'A comprehensive telemedicine and health-tracking prototype featuring virtual consultations, health monitoring, and appointment management.',
      tech: ['Flutter', 'GetX', 'fl_chart'],
      link: 'https://github.com/shahriasayad/care_bridge',
      impact: 'Dual-role architecture, telemedicine, health tracking',
      coverImagePath: ImagePaths.careBridgeCover,
    ),
    ProjectModel(
      emoji: '🍛',
      title: 'Meal Khata',
      description:
          'A mess management app designed to simplify shared living finances by tracking daily meals, expenses, and member contributions.',
      tech: ['Flutter', 'Hive', 'PDF Generation'],
      link: 'https://github.com/shahriasayad/meal_khata',
      impact: 'Automated financial summaries, PDF reporting, offline-first',
      coverImagePath: ImagePaths.mealKhataCover,
    ),
    ProjectModel(
      emoji: '⛅',
      title: 'Weather Forecast',
      description:
          'A Flutter-based weather forecast application providing real-time meteorological data and hourly forecasts using the OpenWeatherMap API.',
      tech: ['Flutter', 'REST API', 'GetX'],
      link: 'https://github.com/shahriasayad/weather_forecast_app',
      impact: 'Real-time updates, detailed metrics, modern interface',
      coverImagePath: ImagePaths.weatherForecastCover,
    ),
    ProjectModel(
      emoji: '📝',
      title: 'ShareList',
      description:
          'A streamlined task management application to efficiently organize, track, and color-code daily to-dos with real-time sync.',
      tech: ['Flutter', 'Firebase', 'Google Auth'],
      link: 'https://github.com/shahriasayad/ShareList_UsingFirebase',
      impact: 'Real-time sync, media integration, secure access',
      coverImagePath: ImagePaths.shareListCover,
    ),
  ];

  List<ProjectModel> get featuredProjects =>
      projects.isEmpty ? const <ProjectModel>[] : [projects.first];

  List<ProjectModel> get supportingProjects =>
      projects.length <= 1 ? const <ProjectModel>[] : projects.skip(1).toList();

  List<GlobalKey> get sectionKeys => [
    heroKey,
    aboutKey,
    experienceKey,
    projectsKey,
    skillsKey,
    educationKey,
    contactKey,
  ];

  // ── Experience ─────────────────────────────────────────────
  final experience = <ExperienceModel>[
    ExperienceModel(
      role: 'Flutter App Developer',
      company: 'Softvence Agency',
      period: 'Dec 2025 – Aug 2026 (9 mos)',
      companyUrl: 'https://softvence.agency/',
      description:
          'Developed and maintained cross-platform mobile applications using Flutter. '
          'Focused on implementing clean architecture, optimizing app performance, and building responsive user interfaces.',
    ),
  ];

  // ── Achievements ──────────────────────────────────────────────
  final achievements = <AchievementModel>[
    AchievementModel(
      title: 'Industrial Attachment',
      organization: 'BdCalling Academy',
      organizationUrl: 'https://bdcalling.com/partnership/bdcalling-academy',
      description:
          'Completed a 3-month industrial training in Flutter Development. Worked on real-life projects and gained hands-on experience with live app development.',
    ),
    AchievementModel(
      title: 'Programming Contest',
      organization: 'Brahmanbaria Polytechnic Institute',
      organizationUrl: 'https://brahmanbaria.polytech.gov.bd/',
      description:
          'Achieved 8th place among 34 participants in a coding competition using Python programming language.',
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

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_handleScroll);
    loadSkillColors();
  }

  void _handleScroll() {
    _updateActiveSection();
  }

  void _updateActiveSection() {
    const anchorOffset = 180.0;

    for (var index = 0; index < sectionKeys.length; index++) {
      final key = sectionKeys[index];
      final context = key.currentContext;
      if (context == null) {
        continue;
      }

      final renderObject = context.findRenderObject();
      if (renderObject is! RenderBox || !renderObject.hasSize) {
        continue;
      }

      final offset = renderObject.localToGlobal(Offset.zero).dy;
      if (offset - anchorOffset <= 0) {
        activeSectionIndex.value = index;
      }
    }
  }

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) {
      return;
    }

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  Future<void> loadSkillColors() async {
    for (final skill in skills) {
      final iconPath = skill.iconPath;
      if (iconPath == null) {
        continue;
      }

      final color = await IconColorExtractor.extractDominantColor(iconPath);
      skill.setCachedColor(color);
    }

    skillPaletteReady.value = true;
  }

  Future<void> submitContactForm() async {
    if (!(contactFormKey.currentState?.validate() ?? false)) {
      return;
    }

    isContactSubmitting.value = true;

    try {
      final response = await http
          .post(
            Uri.parse('https://formsubmit.co/ajax/${email.value}'),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: {
              'email': contactEmailController.text,
              'message': contactMessageController.text,
              '_captcha': 'false',
            },
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception('Request timeout'),
          );

      if (response.statusCode == 200 || response.statusCode == 201) {
        contactEmailController.clear();
        contactMessageController.clear();
        Get.snackbar(
          'Success',
          'Message sent successfully!',
          backgroundColor: Colors.green.withValues(alpha: 0.7),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      } else {
        throw Exception('Failed: ${response.statusCode}');
      }
    } catch (_) {
      Get.snackbar(
        'Error',
        'Failed to send message. Please try again.',
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isContactSubmitting.value = false;
    }
  }

  @override
  void onClose() {
    scrollController.removeListener(_handleScroll);
    scrollController.dispose();
    contactEmailController.dispose();
    contactMessageController.dispose();
    super.onClose();
  }
}
