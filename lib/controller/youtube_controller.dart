import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import '../model/youtube_video_model.dart';

class YoutubeController extends GetxController {
  var isLoading = true.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  var videos = <YoutubeVideoModel>[].obs;
  var channelTitle = ''.obs;
  var channelThumbnail = ''.obs;

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

  Future<void> playVideo(YoutubeVideoModel video) async {
    try {
      final Uri url = Uri.parse(video.watchUrl); // Asumiendo que tienes una propiedad url en tu modelo
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } else {
        Get.snackbar(
          'Error',
          'No se pudo abrir el video',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error al abrir el video: $e');
      Get.snackbar(
        'Error',
        'No se pudo abrir el video',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Ya no necesitamos estas variables y métodos
  // var selectedVideoUrl = ''.obs;
  // var isVideoPlaying = false.obs;
  // void stopVideo() { ... }
}