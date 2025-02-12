import 'package:get/get.dart';
import 'package:compaz_radio/controller/splash_controller.dart';
import 'package:compaz_radio/views/screen/about_screen.dart';
import 'package:compaz_radio/views/screen/home_screen.dart';
import 'package:compaz_radio/views/screen/live_chat_screen.dart';
import 'package:compaz_radio/views/screen/radio_list_screen.dart';
import 'package:compaz_radio/views/screen/settings_screen.dart';
import 'package:compaz_radio/views/screen/splash_screen.dart';

import '../views/screen/bottom_nav/bottom_navigation_widget.dart';
import '../views/screen/bottom_nav/video_streaming_screen.dart';

class Routes {
  static const String splashScreen = '/splashScreen';
  static const String homeScreen = '/homeScreen';
  static const String aboutScreen = '/aboutScreen';
  static const String settingsScreen = '/settingsScreen';
  static const String radioListScreen = '/radioListScreen';
  static const String liveChatScreen = '/liveChatScreen';
  static const String bottomNavigationWidget = '/bottomNavigationWidget';
  static const String videoStreamingScreen = '/videoStreamingScreen';

  static var list = [
    GetPage(
        name: splashScreen,
        page: () => const SplashScreen(),
        binding: BindingsBuilder(() {
          Get.put(
            SplashController(),
          );
        })),
    GetPage(
      name: homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: aboutScreen,
      page: () => const AboutScreen(),
    ),
    GetPage(
      name: settingsScreen,
      page: () => SettingsScreen(),
    ),
    GetPage(
      name: radioListScreen,
      page: () => const RadioListScreen(),
    ),
    GetPage(
      name: liveChatScreen,
      page: () => const LiveChatScreen(),
    ),
    GetPage(
      name: bottomNavigationWidget,
      page: () => BottomNavigationWidget(),
    ),
    GetPage(
      name: videoStreamingScreen,
      page: () => VideoStreamingScreen(embedUrl: '',),
    ),
  ];
}
