import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/project_model.dart';
import '../models/experience_model.dart';
import '../models/achievement_model.dart';
import '../models/education_model.dart';
import '../models/skill_model.dart';
import '../models/social_link_model.dart';

/// PortfolioController - ViewModel managing all portfolio data and state
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
  final imageUrl = 'assets/images/profile2.jpg';

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
      iconPath: 'assets/icons/flutter.png',
    ),
    SkillModel(
      name: 'Dart',
      proficiency: 0.90,
      category: 'Frontend',
      icon: Icons.code,
      iconPath: 'assets/icons/dart.png',
    ),
    SkillModel(
      name: 'Python',
      proficiency: 0.50,
      category: 'Frontend',
      icon: Icons.terminal,
      iconPath: 'assets/icons/python.png',
    ),
    // State Management
    SkillModel(
      name: 'GetX',
      proficiency: 0.95,
      category: 'State Management',
      icon: Icons.settings,
      iconPath: 'assets/icons/getx.png',
    ),
    // Backend & Data
    SkillModel(
      name: 'Firebase',
      proficiency: 0.80,
      category: 'Backend',
      icon: Icons.cloud,
      iconPath: 'assets/icons/firebase.png',
    ),
    SkillModel(
      name: 'REST API',
      proficiency: 0.85,
      category: 'Backend',
      icon: Icons.api,
      iconPath: 'assets/icons/swagger.png',
    ),
    SkillModel(
      name: 'Hive',
      proficiency: 0.80,
      category: 'Local Storage',
      icon: Icons.storage,
      iconPath: 'assets/icons/hive.png',
    ),
    SkillModel(
      name: 'Shared Preference',
      proficiency: 0.88,
      category: 'Local Storage',
      icon: Icons.save,
      iconPath: 'assets/icons/sharedpreferences.png',
    ),
    // DevOps & Tools
    SkillModel(
      name: 'Git',
      proficiency: 0.95,
      category: 'DevOps',
      icon: Icons.merge_type,
      iconPath: 'assets/icons/git.png',
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

  // ── Reactive state ─────────────────────────────────────────
  final activeSection = 0.obs; // tracks nav highlight
  final isNavVisible = true.obs;
}
