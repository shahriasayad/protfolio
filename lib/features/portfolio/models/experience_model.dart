class ExperienceModel {
  final String role;
  final String company;
  final String period;
  final String description;
  final String? companyUrl;

  const ExperienceModel({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    this.companyUrl,
  });
}
