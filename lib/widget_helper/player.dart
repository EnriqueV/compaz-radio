import 'package:animate_icons/animate_icons.dart';
import 'package:compaz_radio/utils/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:lottie/lottie.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:compaz_radio/controller/home_controller.dart';
import 'package:compaz_radio/data/radio_list_data.dart';
import 'package:compaz_radio/model/radio_list_model.dart';
import 'package:compaz_radio/utils/dimsensions.dart';
import 'package:compaz_radio/utils/size.dart';
import 'package:compaz_radio/utils/utils.dart';
import 'package:compaz_radio/widget_helper/network_widget.dart';

// Constantes necesarias
const double playerMinHeight = 70;
const double miniPlayerPercentageDeclaration = 0.2;
final currentlyPlaying = Rx<RadioListModel?>(null);
const mainSpaceBet = MainAxisAlignment.spaceBetween;
const mainCenter = MainAxisAlignment.center;
const crossCenter = CrossAxisAlignment.center;

// Funciones de utilidad
double percentageFromValueInRange({
  required double min,
  required double max,
  required double value,
}) {
  return (value - min) / (max - min);
}

double valueFromPercentageInRange({
  required double min,
  required double max,
  required double percentage,
}) {
  return percentage * (max - min) + min;
}

final ValueNotifier<double> playerExpandProgress = ValueNotifier(playerMinHeight);
final MiniplayerController controller = MiniplayerController();
final _controller = Get.put(HomeController());

class DetailedPlayer extends StatelessWidget {
  final RadioListModel radioListModel;
  final MiniplayerController controller;

   const DetailedPlayer({
    Key? key, 
    required this.radioListModel,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Miniplayer(
       valueNotifier: playerExpandProgress,
  minHeight: playerMinHeight,
  maxHeight: MediaQuery.of(context).size.height,
  controller: controller, // Usar el controlador pasado
  elevation: 4,
      onDismissed: () => currentlyPlaying.value = null,
      curve: Curves.easeOut,
      builder: (height, percentage) {
        final bool miniPlayer = percentage < miniPlayerPercentageDeclaration;
        final double width = MediaQuery.of(context).size.width;
        final maxImgSize = width * 0.35;
        if (!miniPlayer) {
          var percentageExpandedPlayer = percentageFromValueInRange(
              min: MediaQuery.of(context).size.height *
                      miniPlayerPercentageDeclaration +
                  playerMinHeight,
              max: MediaQuery.of(context).size.height,
              value: height);
          if (percentageExpandedPlayer < 0) percentageExpandedPlayer = 0;
          final paddingVertical = valueFromPercentageInRange(
              min: 0, max: 4, percentage: percentageExpandedPlayer);
          final double heightWithoutPadding = height - paddingVertical * 2;
          final double imageSize = heightWithoutPadding > maxImgSize
              ? maxImgSize
              : heightWithoutPadding;

          final sliderValue = 0.3.obs;
          return Container(
            decoration:
                BoxDecoration(color: CustomColor.primaryColor.withOpacity(0.9)),
            child: Column(
              mainAxisAlignment: mainSpaceBet,
              children: [
                Expanded(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: Dimensions.marginSize),
                    child: GlassmorphicContainer(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 0.h,
                      borderRadius: Dimensions.borderRadius * 1,
                      blur: 10,
                      alignment: Alignment.bottomCenter,
                      border: 2,
                      linearGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            CustomColor.primaryColor.withOpacity(0.9),
                            CustomColor.primaryColor.withOpacity(0.5),
                          ],
                          stops: const [
                            0.1,
                            1,
                          ]),
                      borderGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).primaryColor.withOpacity(0.9),
                          Theme.of(context).primaryColor.withOpacity(0.5),
                        ],
                      ),
                      child: ListView(
                        children: [
                          Obx(() {
                            return Container(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Container(
                                    height: imageSize,
                                    margin: EdgeInsets.all(
                                        Dimensions.marginSize * 0.5),
                                    alignment: Alignment.center,
                                    child: Lottie.asset(
                                      'assets/lottie.json',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Text(
                                      radioChanelList[_controller.index.value]
                                          .title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ],
                              ),
                            );
                          }),
                          Row(
                            mainAxisAlignment: mainCenter,
                            children: [
                              const Icon(
                                Icons.volume_mute,
                                color: Colors.white,
                              ),
                              Obx(() => SizedBox(
                                    width: 250.w,
                                    child: Slider(
                                      min: 0.0,
                                      max: 1.0,
                                      activeColor: Colors.white,
                                      inactiveColor:
                                          Colors.white.withOpacity(0.3),
                                      thumbColor:
                                          Theme.of(context).primaryColor,
                                      value: sliderValue.value,
                                      onChanged: (value) async {
                                        sliderValue.value = value;
                                        await _controller.assetsAudioPlayer
                                            .setVolume(sliderValue.value);
                                      },
                                    ),
                                  )),
                              const Icon(
                                Icons.volume_up,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Obx(
                            () {
                              return Column(
                                crossAxisAlignment: crossCenter,
                                children: [
                                  Text(
                                    _controller.titleValue.value,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  Text(
                                    _controller.artistValue.value,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Opacity(
                    opacity: percentageExpandedPlayer,
                    child: Column(
                      mainAxisAlignment: mainSpaceBet,
                      children: [
                        Obx(() {
                          return Expanded(
                            child: Row(
                              mainAxisAlignment: mainCenter,
                              children: [
                                InkWell(
                                  onTap: () {
                                    /*if (_controller.index.value == 2) {
                                      _controller.assetsAudioPlayer.stop();
                                      _controller.index.value = 1;
                                      _controller.audioCall();
                                    } else if (_controller.index.value == 1) {
                                      _controller.assetsAudioPlayer.stop();
                                      _controller.index.value = 0;
                                      _controller.audioCall();
                                    } else if (_controller.index.value == 0) {
                                      _controller.assetsAudioPlayer.stop();
                                      _controller.index.value = 2;
                                      _controller.audioCall();
                                    }*/
                                  },
                                  child: const Icon(
                                    Icons.skip_previous,
                                    size: 40,
                                  ),
                                ),
                                addHorizontalSpace(20.w),
                                SizedBox(
                                  width: 63.w,
                                  height: 63.h,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        CustomColor.primaryColor,
                                    child: AnimateIcons(
                                      startIcon: _controller.isPressed.value
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      endIcon: !_controller.isPressed.value
                                          ? Icons.play_arrow
                                          : Icons.pause,
                                      size: 40.0,
                                      controller: _controller.controller,
                                      onStartIconPress: () {
                                        _controller.assetsAudioPlayer.stop();
                                        _controller.isPressed.value =
                                            !_controller.isPressed.value;
                                        return true;
                                      },
                                      onEndIconPress: () {
                                        _controller.assetsAudioPlayer.play();
                                        _controller.isPressed.value =
                                            !_controller.isPressed.value;
                                        return true;
                                      },
                                      duration:
                                          const Duration(milliseconds: 500),
                                      startIconColor: Colors.white,
                                      endIconColor: Colors.white,
                                      clockwise: false,
                                    ),
                                  ),
                                ),
                                addHorizontalSpace(20.w),
                                InkWell(
                                    onTap: () {
                                     /* if (_controller.index.value == 0) {
                                        _controller.assetsAudioPlayer.stop();
                                        _controller.index.value = 1;
                                        _controller.audioCall();
                                      } else if (_controller.index.value == 1) {
                                        _controller.assetsAudioPlayer.stop();
                                        _controller.index.value = 2;
                                        _controller.audioCall();
                                      } else if (_controller.index.value == 2) {
                                        _controller.assetsAudioPlayer.stop();
                                        _controller.index.value = 0;
                                        _controller.audioCall();
                                      } else {
                                        _controller.index.value = 0;
                                      }*/
                                    },
                                    child: const Icon(
                                      Icons.skip_next,
                                      size: 40,
                                    )),
                              ],
                            ),
                          );
                        }),
                        Expanded(
                          child: _socialIcons(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        //MiniPlayer
        final percentageMiniPlayer = percentageFromValueInRange(
            min: playerMinHeight,
            max: MediaQuery.of(context).size.height *
                    miniPlayerPercentageDeclaration +
                playerMinHeight,
            value: height);

        final elementOpacity = 1 - 1 * percentageMiniPlayer;
        return Container(
          decoration: BoxDecoration(color: CustomColor.primaryColor),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: maxImgSize),
                      child: Lottie.asset(
                        'assets/lottie.json',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Opacity(
                          opacity: elementOpacity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(radioListModel.title,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              Text(
                                radioListModel.subTitle,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: Opacity(
                        opacity: elementOpacity,
                        child: Obx(() {
                          return AnimateIcons(
                            startIcon: _controller.isPressed.value
                                ? Icons.pause
                                : Icons.play_arrow,
                            endIcon: !_controller.isPressed.value
                                ? Icons.play_arrow
                                : Icons.pause,
                            size: 40.0,
                            controller: _controller.controller,
                            onStartIconPress: () {
                              _controller.assetsAudioPlayer.stop();
                              _controller.isPressed.value =
                                  !_controller.isPressed.value;
                              return true;
                            },
                            onEndIconPress: () {
                              _controller.assetsAudioPlayer.play();
                              _controller.isPressed.value =
                                  !_controller.isPressed.value;
                              return true;
                            },
                            duration: const Duration(milliseconds: 500),
                            startIconColor: Colors.black,
                            endIconColor: Colors.black,
                            clockwise: false,
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _socialIcons(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.marginSize),
      child: Column(
        crossAxisAlignment: crossCenter,
        children: [
          const Expanded(child: NetworkWidget()),
          addVerticalSpace(5.h),
          Expanded(
  child: Obx(() {
    if (_controller.banners.isEmpty) {
      return Container(
        height: 50.h,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[300],
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    return Container(
      height: 50.h,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: Container(
          key: ValueKey<String>(_controller.getCurrentBannerUrl()),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(_controller.getCurrentBannerUrl()),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }),
),
        ],
      ),
    );
  }
}