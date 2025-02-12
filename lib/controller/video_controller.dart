import 'package:get/get.dart';

class VideoController extends GetxController {
  RxBool isClick = false.obs;
  RxInt indexVisible = 0.obs;
  RxString videoURL = "".obs;
}
