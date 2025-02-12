class BannerModel {
  final String id;
  final String name;
  final String url;
  final String thumbnail;

  BannerModel({
    required this.id,
    required this.name,
    required this.url,
    required this.thumbnail,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
    );
  }
}