import 'package:compaz_radio/widget_helper/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:compaz_radio/utils/custom_color.dart';
import 'video_player_view.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final String url;
  final String title;
  final DataSourceType sourceType;

  const VideoScreen({
    Key? key,
    required this.url,
    required this.title,
    required this.sourceType,
  }) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: CustomColor.primaryColor,
          title: Text(widget.title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              await SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
              ]);
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
          child: Center(
            child: VideoPlayerView(
              url: widget.url,
              dataSourceType: widget.sourceType,
            ),
          ),
        ),
      ),
    );
  }
}