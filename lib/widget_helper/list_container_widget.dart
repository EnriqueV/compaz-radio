import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:compaz_radio/controller/home_controller.dart';
import 'package:compaz_radio/data/radio_list_data.dart';
import 'package:compaz_radio/model/radio_list_model.dart';
import 'package:compaz_radio/widget_helper/audio_list_tile.dart';

typedef OnTap(final RadioListModel radioListModel);

class AudioUi extends StatelessWidget {
  final OnTap onTap;

  AudioUi({Key? key, required this.onTap}) : super(key: key);
  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      // padding: const EdgeInsets.all(0),
      children: [
        for (RadioListModel a in radioChanelList)
          AudioListTile(
              radioListModel: a,
              onTap: () {
                onTap(a);
                _controller.index.value = a.id;
                _controller.isPressed.value = true;
                _controller.audioCall();

                // if (_controller.index.value == 0) {
                //   _controller.isPressed.value = true;
                //   _controller.audioCall();
                // } else if (_controller.index.value == 1) {
                //   _controller.isPressed.value = true;
                //   _controller.audioCall();
                // } else if (_controller.index.value == 2) {
                //   _controller.isPressed.value = true;
                //   _controller.audioCall();
                // }
              })
      ],
    );
  }
}
