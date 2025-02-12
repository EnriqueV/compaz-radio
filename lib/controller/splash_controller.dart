import 'dart:async';
import 'package:get/get.dart';
import 'package:compaz_radio/routes/routes.dart';

class SplashController extends GetxController {

  @override
  void onReady() {
    super.onReady();
    _goToScreen();
  }

  _goToScreen() async {
    Timer(const Duration(seconds: 3),
        () => Get.offAllNamed(Routes.bottomNavigationWidget));
  }
}
