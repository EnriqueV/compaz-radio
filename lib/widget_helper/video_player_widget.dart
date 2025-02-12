import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:compaz_radio/utils/custom_color.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final String title;

  const VideoPlayerWidget({
    Key? key,
    required this.videoUrl,
    required this.title,
  }) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );

      await _videoPlayerController!.initialize();

      if (!mounted) return;

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        aspectRatio: 16 / 9,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
        ],
        placeholder: Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(
              color: CustomColor.primaryColor,
            ),
          ),
        ),
      );

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print('Error al inicializar el video: $error');
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error al cargar el video';
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: CustomColor.primaryColor,
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: _isLoading
              ? CircularProgressIndicator(color: CustomColor.primaryColor)
              : _errorMessage != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, 
                            size: 48, 
                            color: CustomColor.primaryColor),
                        SizedBox(height: 16),
                        Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColor.primaryColor,
                          ),
                          onPressed: _initializePlayer,
                          child: Text('Reintentar'),
                        ),
                      ],
                    )
                  : _chewieController != null
                      ? Chewie(controller: _chewieController!)
                      : Center(
                          child: Text(
                            'No se pudo cargar el video',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
        ),
      ),
    );
  }
}