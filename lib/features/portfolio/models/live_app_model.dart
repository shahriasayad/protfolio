class LiveAppModel {
  final String title;
  final String description;
  final List<String> features;
  final String coverImagePath;
  final String? appStoreLink;
  final String? playStoreLink;
  final String? testFlightLink;

  const LiveAppModel({
    required this.title,
    required this.description,
    required this.features,
    required this.coverImagePath,
    this.appStoreLink,
    this.playStoreLink,
    this.testFlightLink,
  });
}
