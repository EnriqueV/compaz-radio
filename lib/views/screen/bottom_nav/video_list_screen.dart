import 'package:compaz_radio/views/screen/bottom_nav/video_streaming_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:compaz_radio/utils/custom_color.dart';
import 'package:video_player/video_player.dart';
import '../../../controller/youtube_controller.dart';
import '../../../utils/dimsensions.dart';
import '../../../widget_helper/video_player_widget.dart';

class VideoListScreen extends StatelessWidget {
  VideoListScreen({super.key});
  final controller = Get.put(YoutubeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.isError.value) {
        return Center(child: Text(controller.errorMessage.value));
      }

      return Column(
        children: [
          Obx(
            () => Visibility(
              visible: controller.isVideoPlaying.value,
              child: Stack(
                children: [
                   VideoStreamingScreen( // Cambiado de VideoPlayerView a VideoStreamingScreen
                    embedUrl: controller.selectedVideoUrl.value,
                  ),
                  Positioned(
                    top: 12,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close_outlined),
                      onPressed: () => controller.stopVideo(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: controller.videos.length,
              itemBuilder: (context, index) {
                final video = controller.videos[index];
                return Card(
                     color: CustomColor.primaryBackgroundColor,
                  margin: EdgeInsets.all(Dimensions.defaultPaddingSize * 0.5),
                  child: InkWell(
                    onTap: () => controller.playVideo(video),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 90,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(video.thumbnail),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(Dimensions.defaultPaddingSize * 0.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  video.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  video.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 254, 254, 254),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}