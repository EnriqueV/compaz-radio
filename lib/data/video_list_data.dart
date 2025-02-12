class VideoListModel {
  final String title, image, url;

  VideoListModel({
    required this.title,
    required this.image,
    required this.url,
  });
}

List<VideoListModel> videoListData = [
  VideoListModel(
      title: "Harmonious Beats: A Musical Journey ",
      image: "assets/video_image/1.jpg",
      url:
          "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8"),
  VideoListModel(
    title: "Dance to the Rhythm of Dreams",
    image: "assets/video_image/2.jpg",
    url:
        "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.mp4/.m3u8",
  ),
  VideoListModel(
    title: "The Roar of Vengeance: Unleashed Havoc",
    image: "assets/video_image/5.jpg",
    url: "https://lakay.online/public/telelabrise/index.m3u8",
  ),
  VideoListModel(
      title: "Game On: The Ultimate Sports Showdown",
      image: "assets/video_image/6.jpg",
      url:
          "http://d3rlna7iyyu8wu.cloudfront.net/skip_armstrong/skip_armstrong_stereo_subs.m3u8"),
  VideoListModel(
      title: "Midnight Justice: A Vigilante's Tale",
      image: "assets/video_image/7.jpg",
      url: "https://lakay.online/public/telelabrise/index.m3u8"),
];
