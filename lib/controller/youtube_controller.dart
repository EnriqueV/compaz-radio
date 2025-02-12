import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:compaz_radio/views/screen/bottom_nav/video_streaming_screen.dart';
import 'dart:convert';
import '../model/youtube_video_model.dart';

class YoutubeController extends GetxController {
  var isLoading = true.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  var videos = <YoutubeVideoModel>[].obs;
  var channelTitle = ''.obs;
  var channelThumbnail = ''.obs;
  var selectedVideoUrl = ''.obs;
  var isVideoPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    try {
      isLoading(true);
      isError(false);
      
      final response = await http.get(Uri.parse(
          'https://compaz-api-production.up.railway.app/api/youtube/videos/UCUR0-e6nq6t-Gbkvh14Xnng?maxResults=30'));

      if (response.statusCode == 200) {
        final YoutubeResponseModel youtubeResponse = 
            YoutubeResponseModel.fromJson(json.decode(response.body));
            
        videos.value = youtubeResponse.videos;
        channelTitle.value = youtubeResponse.channelTitle;
        channelThumbnail.value = youtubeResponse.channelThumbnail;
      } else {
        isError(true);
        errorMessage.value = 'Error al cargar los videos';
      }
    } catch (e) {
      isError(true);
      errorMessage.value = 'Error de conexión: $e';
    } finally {
      isLoading(false);
    }
  }

 void playVideo(YoutubeVideoModel video) {
  // Construimos la URL de embed optimizada para móviles
  final embedUrl = 'https://www.youtube.com/embed/${video.id}?autoplay=1&playsinline=1';
  Get.to(() => VideoStreamingScreen(embedUrl: embedUrl));
}

  void stopVideo() {
    isVideoPlaying(false);
  }
}