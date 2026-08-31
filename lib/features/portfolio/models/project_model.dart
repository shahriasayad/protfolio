class ProjectModel {
  final String title;
  final String description;
  final List<String> tech;
  final String link;
  final String emoji;
  final String impact;
  final String? coverImagePath;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.tech,
    required this.link,
    required this.emoji,
    required this.impact,
    this.coverImagePath,
  });
}
