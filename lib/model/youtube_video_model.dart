class YoutubeVideoModel {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final String publishedAt;
  final String watchUrl;
  final String embedUrl;

  YoutubeVideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.publishedAt,
    required this.watchUrl,
    required this.embedUrl,
  });

  factory YoutubeVideoModel.fromJson(Map<String, dynamic> json) {
    return YoutubeVideoModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      watchUrl: json['watchUrl'] ?? '',
      embedUrl: json['embedUrl'] ?? '',
    );
  }
}

class YoutubeResponseModel {
  final String channelTitle;
  final String channelThumbnail;
  final List<YoutubeVideoModel> videos;

  YoutubeResponseModel({
    required this.channelTitle,
    required this.channelThumbnail,
    required this.videos,
  });

  factory YoutubeResponseModel.fromJson(Map<String, dynamic> json) {
    return YoutubeResponseModel(
      channelTitle: json['channelTitle'] ?? '',
      channelThumbnail: json['channelThumbnail'] ?? '',
      videos: (json['videos'] as List)
          .map((video) => YoutubeVideoModel.fromJson(video))
          .toList(),
    );
  }
}