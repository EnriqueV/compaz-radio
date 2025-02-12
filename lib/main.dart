import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multi_radio/helper/admob_helper.dart';
import 'package:multi_radio/languages/datastorage_service.dart';
import 'package:multi_radio/languages/language_translation.dart';
import 'package:multi_radio/routes/routes.dart';
import 'package:multi_radio/utils/custom_color.dart';
import 'package:multi_radio/utils/strings.dart';
import 'package:multi_radio/utils/themes.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart'; 


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // initializing getStorage
  await initialConfig();
  AdMobHelper.initialization();
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

Future<void> initialConfig() async {
  await Get.putAsync(() => StorageService().init());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = Get.put(StorageService());

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    const String oneSignalAppId = '4befb585-a3a7-4bf6-8b15-2549c26f861a';
  //  await OneSignal.shared.setAppId(oneSignalAppId);
  }

  final dark = ThemeData.dark();
  final themeCollection = ThemeCollection(themes: {
    AppThemes.light: ThemeData(
        primaryColor: CustomColor.primaryColor,
        scaffoldBackgroundColor: CustomColor.whiteColor,
        textTheme: const TextTheme(
          // ignore: deprecated_member_use
          displayLarge: TextStyle(color: CustomColor.darkPrimaryColor),
          // ignore: deprecated_member_use
          displayMedium: TextStyle(color: CustomColor.darkPrimaryColor),
          // ignore: deprecated_member_use
          bodyMedium: TextStyle(color: CustomColor.darkPrimaryColor),
          // ignore: deprecated_member_use
          titleMedium: TextStyle(color: CustomColor.darkPrimaryColor),
        ),
        iconTheme: const IconThemeData(color: CustomColor.darkPrimaryColor)),
    AppThemes.dark: ThemeData(
        primaryColor: CustomColor.darkPrimaryColor,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          // ignore: deprecated_member_use
          displayLarge: TextStyle(color: CustomColor.whiteColor),
          // ignore: deprecated_member_use
          displayMedium: TextStyle(color: CustomColor.whiteColor),
          // ignore: deprecated_member_use
          bodyMedium: TextStyle(color: CustomColor.whiteColor),
          // ignore: deprecated_member_use
          titleMedium: TextStyle(color: CustomColor.whiteColor),
        ),
        iconTheme: const IconThemeData(color: CustomColor.whiteColor)),
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, child) => DynamicTheme(
          themeCollection: themeCollection,
          defaultThemeId: AppThemes.dark,
          builder: (context, theme) {
            return GetMaterialApp(
              builder: (context, widget) {   
                return MediaQuery(
                  // ignore: deprecated_member_use
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                );
              },
              translations: AppTranslations(),
              locale: storage.languageCode != null
                  ? Locale(storage.languageCode!, storage.countryCode)
                  : const Locale('en', 'US'),
              fallbackLocale: Locale('en', 'US'),
              title: Strings.multiRadio,
              debugShowCheckedModeBanner: false,
              theme: theme,
              navigatorKey: Get.key,
              initialRoute: Routes.splashScreen,
              getPages: Routes.list,
            );
          }),
    );
  }
}
