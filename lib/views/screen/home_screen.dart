// ignore_for_file: unnecessary_statements

import 'package:animate_icons/animate_icons.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:multi_radio/controller/home_controller.dart';
import 'package:multi_radio/helper/unit_id_helper.dart';
import 'package:multi_radio/helper/admob_helper.dart';
import 'package:multi_radio/utils/dimsensions.dart';
import 'package:multi_radio/utils/size.dart';
import 'package:multi_radio/utils/strings.dart';
import 'package:multi_radio/widget_helper/image_widget.dart';
import 'package:multi_radio/widget_helper/network_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  final _controller = Get.put(HomeController());
  final assetsAudioPlayer = AssetsAudioPlayer();
  final sliderValue = 0.3.obs;
  InterstitialAd? interstitialAd;
  
  Future<bool> _onBackPress() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Strings.multiRadio.tr),
          content: Text(Strings.exitFromApp.tr),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // ignore: deprecated_member_use
      onPopInvoked: (value) {
        _onBackPress;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          centerTitle: true,
        ),
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      children: [
        Column(
          mainAxisAlignment: mainSpaceBet,
          crossAxisAlignment: crossCenter,
          children: [
            _upperContainer(context),
            Obx(() {
              return Center(
                child: Row(
                  mainAxisAlignment: mainCenter,
                  children: [
                    InkWell(
                        onTap: () {
                          _controller.assetsAudioPlayer.previous();
                        },
                        child: const Icon(
                          Icons.skip_previous,
                          size: 40,
                          // color: CustomColor.whiteColor,
                        )),
                    addHorizontalSpace(20.w),
                    SizedBox(
                      width: 62.75.w,
                      height: 62.75.h,
                      child: CircleAvatar(
                        // backgroundColor: Colors.white,
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
                            // ignore: avoid_print
                            print("Clicked on pause Button");
                            _controller.assetsAudioPlayer.stop();
                            InterstitialAd.load(
                              adUnitId: UnitIdHelper.interstitialAdUnitId,
                              request: const AdRequest(),
                              adLoadCallback:
                                  InterstitialAdLoadCallback(onAdLoaded: (ad) {
                                interstitialAd = ad;
                                interstitialAd!.show();
                                interstitialAd!.fullScreenContentCallback =
                                    FullScreenContentCallback(
                                        onAdFailedToShowFullScreenContent:
                                            ((ad, error) {
                                  ad.dispose();
                                  debugPrint(error.message);
                                }), onAdDismissedFullScreenContent: (ad) {
                                  ad.dispose();
                                  interstitialAd!.dispose();
                                });
                              }, onAdFailedToLoad: (error) {
                                // ignore: avoid_print
                                print('interstitial ad is not done $error');
                              }),
                            );
                            _controller.isPressed.value =
                                !_controller.isPressed.value;
                            // ignore: avoid_print
                            print(_controller.isPressed.value);

                            return true;
                          },
                          onEndIconPress: () {
                            // ignore: avoid_print
                            print("Clicked on play Button");
                            _controller.assetsAudioPlayer.play();
                            _controller.isPressed.value =
                                !_controller.isPressed.value;
                            // ignore: avoid_print
                            print(_controller.isPressed.value);

                            // assetsAudioPlayer.play();
                            return true;
                          },
                          duration: const Duration(milliseconds: 500),
                          startIconColor: Colors.black,
                          endIconColor: Colors.black,
                          clockwise: false,
                        ),
                        // ),
                      ),
                    ),
                    addHorizontalSpace(20.w),
                    InkWell(
                        onTap: () {
                          _controller.assetsAudioPlayer
                              .next(keepLoopMode: true);
                        },
                        child: const Icon(
                          Icons.skip_next,
                          size: 40,
                        )),
                  ],
                ),
              );
            }),
            addVerticalSpace(5.h),
          ],
        ),
        _socialIcons(context)
      ],
    );
  }

  _socialIcons(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.marginSize),
      child: Column(
        mainAxisAlignment: mainSpaceBet,
        crossAxisAlignment: crossCenter,
        children: [
          const NetworkWidget(),
          addVerticalSpace(5.h),
          SizedBox(
            height: 50.h,
            child: AdWidget(
              ad: AdMobHelper.getBannerAd()..load(),
              key: UniqueKey(),
            ),
          )
        ],
      ),
    );
  }

  _upperContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.marginSize),
      child: GlassmorphicContainer(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 400,
        borderRadius: Dimensions.borderRadius * 1.5,
        blur: 10,
        alignment: Alignment.bottomCenter,
        border: 2,
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.9),
              Theme.of(context).primaryColor.withOpacity(0.8),
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
        child: Center(
          child: Column(
            mainAxisAlignment: mainCenter,
            children: [
              const ImageWidget(),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: Dimensions.defaultPaddingSize),
                child: Row(
                  mainAxisAlignment: mainCenter,
                  children: [
                    const Icon(
                      Icons.volume_mute,
                      color: Colors.white,
                    ),
                    Obx(() => SizedBox(
                          width: 265.w,
                          child: Slider(
                            min: 0.0,
                            max: 1.0,
                            activeColor: Colors.white,
                            inactiveColor: Colors.white.withOpacity(0.3),
                            thumbColor: Theme.of(context).primaryColor,
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
              ),
              Obx(() {
                return Padding(
                  padding: EdgeInsets.all(Dimensions.defaultPaddingSize * 0.5),
                  child: Column( 

                    
                    mainAxisAlignment: mainCenter,
                    crossAxisAlignment: crossCenter,
                    children: [
                      Text(
                        _controller.titleValue.value,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text( _controller.artistValue.value,style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
              )
            ],
          ),
        ),
      ),
    );
  }
}
