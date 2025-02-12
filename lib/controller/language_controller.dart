import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_radio/utils/local_storage.dart';
import '../languages/datastorage_service.dart';

class LanguageController extends GetxController {
  final storage = Get.find<StorageService>();
  final RxString locale = Get.locale.toString().obs;


  var dropdownValue = false.obs;

  @override
  void onInit() {
    dropdownValue.value = LocalStorage.getThemeState();
    super.onInit();
  }

  final Map<String, dynamic> optionsLocales = {
    'en_US': {
      'languageCode': 'en',
      'countryCode': 'US',
      'description': 'English'
    },
    'es_ES': {
      'languageCode': 'es',
      'countryCode': 'ES',
      'description': 'Español'
    },
  };

  void updateLocale(String? key) {
    final String languageCode = optionsLocales[key]['languageCode'];
    final String countryCode = optionsLocales[key]['countryCode'];
    // Update App
    Get.updateLocale(Locale(languageCode, countryCode));
    // Update obs
    locale.value = Get.locale.toString();
    // Update storage
    storage.write('languageCode', languageCode);
    storage.write('countryCode', countryCode);
  }




}
