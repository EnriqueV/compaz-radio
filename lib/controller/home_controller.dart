import 'dart:async';
import 'package:animate_icons/animate_icons.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:compaz_radio/data/radio_list_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/banner_model.dart';

class HomeController extends GetxController {
  // VARIABLES
  
  // Audio Player
  final assetsAudioPlayer = AssetsAudioPlayer();
  RxInt index = 0.obs;
  var isPressed = false.obs;
  var titleValue = ''.obs;
  var artistValue = ''.obs;
  var isLoading = false.obs;

  // UI Control
  late AnimateIconController controller;
  var isDarkMode = false.obs;

  // Banner
  var currentBannerIndex = 0.obs;
  var banners = <BannerModel>[].obs;
  Timer? bannerTimer;

  // LIFECYCLE METHODS

  @override
  void onInit() {
    super.onInit();
    _initializeController();
    _setupAudioPlayerListeners();
    fetchBanners();
  }

  @override
  void onClose() {
    _disposeResources();
    super.onClose();
  }

  // INITIALIZATION METHODS

  void _initializeController() {
    controller = AnimateIconController();
    audioCall();
  }

  void _setupAudioPlayerListeners() {
    // Estado de reproducción
    assetsAudioPlayer.isPlaying.listen((playing) {
      isPressed.value = playing;
    });

    // Manejo de errores
    assetsAudioPlayer.onErrorDo = (handler) {
      print("Error: ${handler.error.message}");
      isPressed.value = false;
      _retryAudioCall();
      return true;
    };

    // Fin de reproducción
    assetsAudioPlayer.playlistAudioFinished.listen((Playing playing) {
      print("Audio finished: ${playing.audio.assetAudioPath}");
    });
  }

  void _disposeResources() {
    bannerTimer?.cancel();
    assetsAudioPlayer.dispose();
  }

  // AUDIO METHODS

  Future<void> audioCall() async {
    try {
      isLoading.value = true;
      await assetsAudioPlayer.open(
        Playlist(
          audios: audios,
          startIndex: index.value,
        ),
        loopMode: LoopMode.playlist,
        showNotification: true,
        autoStart: false,
        notificationSettings: NotificationSettings(
          stopEnabled: false,
          customPlayPauseAction: (playing) => togglePlay(),
        ),
      );
    } catch (e) {
      print("Error in audioCall: $e");
      _handleAudioError();
    } finally {
      isLoading.value = false;
    }
  }

  void _retryAudioCall() {
    Future.delayed(Duration(seconds: 2), audioCall);
  }

  void _handleAudioError() {
    Get.snackbar(
      'Error',
      'Error al reproducir el audio. Intentando nuevamente...',
      duration: Duration(seconds: 2),
    );
    _retryAudioCall();
  }

  void togglePlay() async {
    try {
      if (assetsAudioPlayer.isPlaying.value) {
        await assetsAudioPlayer.pause();
      } else {
        await assetsAudioPlayer.play();
      }
      isPressed.value = assetsAudioPlayer.isPlaying.value;
      update();
    } catch (e) {
      print("Error toggling play: $e");
    }
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  // BANNER METHODS

  Future<void> fetchBanners() async {
    try {
      final response = await http.get(Uri.parse(
        'https://compaz-api-production.up.railway.app/api/images/folder/banners_compaz'
      ));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        banners.value = data.map((json) => BannerModel.fromJson(json)).toList();
        startBannerRotation();
      }
    } catch (e) {
      print('Error fetching banners: $e');
    }
  }

  void startBannerRotation() {
    bannerTimer?.cancel();
    bannerTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (banners.isNotEmpty) {
        currentBannerIndex.value = (currentBannerIndex.value + 1) % banners.length;
      }
    });
  }

  String getCurrentBannerUrl() {
    if (banners.isEmpty) return '';
    return banners[currentBannerIndex.value].url;
  }
}