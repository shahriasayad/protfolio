import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_tokens.dart';
import '../../../core/constants/asset_paths.dart';
import '../models/achievement_model.dart';
import '../models/education_model.dart';
import '../models/experience_model.dart';
import '../models/live_app_model.dart';
import '../models/portfolio_stat_model.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';
import '../models/social_link_model.dart';
import '../models/tool_model.dart';
import '../services/portfolio_service.dart';

/// ViewModel managing portfolio content, scroll navigation, hover states, and actions.
class PortfolioController extends GetxController {
  PortfolioController({PortfolioService? service})
    : _service = service ?? Get.find<PortfolioService>();

  final PortfolioService _service;

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
  final activeSectionIndex = 0.obs;

  final Set<String> _hoveredIds = <String>{};

  bool isHovered(String id) => _hoveredIds.contains(id);

  void setHovered(String id, bool hovered) {
    final changed = hovered ? _hoveredIds.add(id) : _hoveredIds.remove(id);
    if (changed) {
      update(<Object>['hover_$id']);
    }
  }

  // ── Personal info ──────────────────────────────────────────
  final name = 'Shahria Sayad'.obs;
  final title = 'Flutter Developer'.obs;
  final imageUrl = ImagePaths.profile2;

  final intro =
      'I build fast, cross-platform apps that feel native on every device.'.obs;
  final bio =
      '''
I'm a Flutter developer focused on building clean, reliable, and user-friendly mobile applications.
I enjoy turning ideas and designs into functional products and working across the frontend, APIs, and app architecture.
'''
          .obs;

  final email = 'shahriasayad9@gmail.com'.obs;
  final brandHeadline = 'I build Flutter products with a clear point of view.';
  final brandSummary =
      'Mobile work built around clarity, speed, and user experience that sticks. I focus on interfaces that feel designed, not just functional.';
  final availabilityNote =
      'Available for selective freelance work and product teams that care about detail.';
  final cvUrl = 'https://canva.link/6l65wdwp7qrc8hz';

  final heroStats = const <PortfolioStatModel>[
    PortfolioStatModel(
      value: '4',
      label: 'Live apps',
      detail: 'Published and currently in production.',
      icon: Icons.rocket_launch_outlined,
      accent: AppTokens.statusLive,
    ),
    PortfolioStatModel(
      value: '18',
      label: 'Core skills & tools',
      detail: 'A focused stack for shipping polished mobile products.',
      icon: Icons.layers_outlined,
      accent: AppTokens.accent,
    ),
    PortfolioStatModel(
      value: '6',
      label: 'Featured projects',
      detail: 'Case studies showing range, craft, and delivery.',
      icon: Icons.code_rounded,
      accent: AppTokens.accentWarm,
    ),
  ];

  // ── Tools ──────────────────────────────────────────────────
  final tools = const <ToolModel>[
    ToolModel(name: 'VS Code', iconPath: IconPaths.vsCode, role: 'Code Editor'),
    ToolModel(
      name: 'Android Studio',
      iconPath: IconPaths.androidStudio,
      role: 'Mobile IDE',
    ),
    ToolModel(
      name: 'IntelliJ IDEA',
      iconPath: IconPaths.intellijIdea,
      role: 'JetBrains IDE',
    ),
    ToolModel(name: 'Figma', iconPath: IconPaths.figma, role: 'UI & Specs'),
    ToolModel(
      name: 'Postman',
      iconPath: IconPaths.postman,
      role: 'API Testing',
    ),
    ToolModel(
      name: 'Swagger',
      iconPath: IconPaths.swagger,
      role: 'API Contracts',
    ),
  ];

  // ── Skills ─────────────────────────────────────────────────
  final skills = const <SkillModel>[
    SkillModel(
      name: 'Flutter',
      proficiency: 0.92,
      category: 'Mobile Development',
      icon: Icons.flutter_dash,
      iconPath: IconPaths.flutter,
    ),
    SkillModel(
      name: 'Dart',
      proficiency: 0.90,
      category: 'Mobile Development',
      icon: Icons.code,
      iconPath: IconPaths.dart,
    ),
    SkillModel(
      name: 'GetX',
      proficiency: 0.95,
      category: 'State Management & Data',
      icon: Icons.settings,
      iconPath: IconPaths.getx,
    ),
    SkillModel(
      name: 'Hive',
      proficiency: 0.80,
      category: 'State Management & Data',
      icon: Icons.storage,
      iconPath: IconPaths.hive,
    ),
    SkillModel(
      name: 'Shared Preference',
      proficiency: 0.88,
      category: 'State Management & Data',
      icon: Icons.save,
      iconPath: IconPaths.sharedPreferences,
    ),
    SkillModel(
      name: 'WebRTC / Agora',
      proficiency: 0.85,
      category: 'Backend Services',
      icon: Icons.video_call_outlined,
    ),
    SkillModel(
      name: 'Socket.io',
      proficiency: 0.75,
      category: 'Backend Services',
      icon: Icons.sync,
      iconPath: IconPaths.socketIo,
    ),
    SkillModel(
      name: 'Firebase',
      proficiency: 0.80,
      category: 'Backend Services',
      icon: Icons.cloud,
      iconPath: IconPaths.firebase,
    ),
    SkillModel(
      name: 'REST API',
      proficiency: 0.85,
      category: 'Backend Services',
      icon: Icons.api,
      iconPath: IconPaths.swagger,
    ),
    SkillModel(
      name: 'Git',
      proficiency: 0.95,
      category: 'Version Control',
      icon: Icons.merge_type,
      iconPath: IconPaths.git,
    ),
    SkillModel(
      name: 'GitLab',
      proficiency: 0.85,
      category: 'Version Control',
      icon: Icons.code,
      iconPath: IconPaths.gitlab,
    ),
    SkillModel(
      name: 'GitHub',
      proficiency: 0.95,
      category: 'Version Control',
      icon: Icons.code,
      iconPath: IconPaths.github,
    ),
    SkillModel(
      name: 'Python',
      proficiency: 0.50,
      category: 'Languages',
      icon: Icons.terminal,
      iconPath: IconPaths.python,
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
    LiveAppModel(
      title: 'Jupiter Marine Sales',
      description:
          'A smart boat discovery platform for exploring boats and luxury yachts, with AI-powered search and an intelligent chat assistant to help buyers find the right vessel.',
      features: [
        'Curated boat & luxury yacht marketplace',
        'AI-powered natural-language search',
        'AI chat assistant & smart recommendations',
        'Detailed specs & descriptions',
        'High-quality photo galleries',
        'Platforms: iOS & Android',
      ],
      coverImagePath: ImagePaths.jupiterMarineSalesCover,
      appStoreLink:
          'https://apps.apple.com/us/app/jupiter-marine-sales/id6765932719',
      playStoreLink:
          'https://play.google.com/store/apps/details?id=com.jupitermarinesales.diaz',
    ),
  ];

  // ── Projects ───────────────────────────────────────────────
  final projects = const <ProjectModel>[
    ProjectModel(
      emoji: '📞',
      title: 'Agora Connect',
      description:
          'A cross-platform Flutter app for real-time communication, featuring high-quality peer-to-peer audio/video calling, custom signaling, and call history tracking.',
      tech: ['Flutter', 'Dart', 'Agora RTC Engine', 'WebRTC', 'GetX'],
      link: 'https://github.com/shahriasayad/agora_connect',
      impact:
          'Real-time audio/video calls, custom call signaling, call history tracking, dynamic hardware permission handling.',
      coverImagePath: ImagePaths.agoraConnectCover,
    ),
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

  Map<String, List<SkillModel>> get groupedSkills {
    final grouped = <String, List<SkillModel>>{};
    for (final skill in skills) {
      grouped.putIfAbsent(skill.category, () => <SkillModel>[]).add(skill);
    }
    return grouped;
  }

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
  final experience = const <ExperienceModel>[
    ExperienceModel(
      role: 'Flutter App Developer',
      company: 'Softvence Agency',
      period: 'Nov 2025 – Oct 2026 (1 yr)',
      companyUrl: 'https://softvence.agency/',
      description:
          'Built and maintained cross-platform mobile apps using Flutter. Focused on clean architecture, performance, and responsive UI.',
    ),
  ];

  // ── Achievements ───────────────────────────────────────────
  final achievements = const <AchievementModel>[
    AchievementModel(
      title: 'Industrial Attachment',
      organization: 'BdCalling Academy',
      organizationUrl: 'https://bdcalling.com/partnership/bdcalling-academy',
      description:
          'Completed a 3-month Flutter development training at BdCalling Academy, working on real projects with live app deployments.',
    ),
    AchievementModel(
      title: 'Programming Contest',
      organization: 'Brahmanbaria Polytechnic Institute',
      organizationUrl: 'https://brahmanbaria.polytech.gov.bd/',
      description:
          'Placed 8th out of 34 participants in a Python programming contest at Brahmanbaria Polytechnic Institute.',
    ),
  ];

  // ── Education ──────────────────────────────────────────────
  final education = const <EducationModel>[
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
  final socials = const <SocialLink>[
    SocialLink(
      label: 'GitHub',
      url: 'https://github.com/shahriasayad',
      icon: Icons.code_rounded,
    ),
    SocialLink(
      label: 'LinkedIn',
      url: 'https://www.linkedin.com/in/shahria-sayad-9236a1308/',
      icon: Icons.north_east_rounded,
    ),
    SocialLink(
      label: 'Email',
      url: 'mailto:shahriasayad9@gmail.com',
      icon: Icons.mail_outline_rounded,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_updateActiveSection);
  }

  void _updateActiveSection() {
    const anchorOffset = 180.0;
    var resolvedIndex = 0;

    for (var index = 0; index < sectionKeys.length; index++) {
      final context = sectionKeys[index].currentContext;
      if (context == null) continue;

      final renderObject = context.findRenderObject();
      if (renderObject is! RenderBox || !renderObject.hasSize) continue;

      final offset = renderObject.localToGlobal(Offset.zero).dy;
      if (offset - anchorOffset <= 0) {
        resolvedIndex = index;
      }
    }

    if (activeSectionIndex.value != resolvedIndex) {
      activeSectionIndex.value = resolvedIndex;
    }
  }

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;

    final disableAnimations = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    Scrollable.ensureVisible(
      context,
      duration: disableAnimations
          ? Duration.zero
          : const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
      alignment: 0.04,
    );
  }

  Future<void> openUrl(
    String? url, {
    bool external = false,
    String errorMessage = 'Could not open link.',
  }) async {
    await _service.openExternalUrl(
      url,
      mode: external ? LaunchMode.externalApplication : LaunchMode.platformDefault,
      errorMessage: errorMessage,
    );
  }

  Future<void> openEmailClient() => _service.openEmailClient(email.value);

  Future<void> copyEmail() => _service.copyToClipboard(
    email.value,
    toastMessage: 'Email copied to clipboard',
  );

  Future<void> downloadCV() => _service.openExternalUrl(
    cvUrl,
    errorMessage: 'Could not download CV.',
  );

  String? validateEmail(String? value) => _service.validateEmail(value);

  String? validateMessage(String? value) => _service.validateMessage(value);

  Future<void> submitContactForm() async {
    if (!(contactFormKey.currentState?.validate() ?? false)) {
      return;
    }

    isContactSubmitting.value = true;
    EasyLoading.show(status: 'Sending...');

    try {
      final sent = await _service.submitContactMessage(
        targetEmail: email.value,
        senderEmail: contactEmailController.text,
        message: contactMessageController.text,
      );

      if (sent) {
        contactEmailController.clear();
        contactMessageController.clear();
        EasyLoading.showSuccess('Message sent!');
      } else {
        EasyLoading.showError('Failed to send message.');
      }
    } catch (_) {
      EasyLoading.showError('Error sending message.');
    } finally {
      isContactSubmitting.value = false;
    }
  }

  @override
  void onClose() {
    scrollController.removeListener(_updateActiveSection);
    scrollController.dispose();
    contactEmailController.dispose();
    contactMessageController.dispose();
    super.onClose();
  }
}
