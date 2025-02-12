import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:compaz_radio/controller/language_controller.dart';
import 'package:compaz_radio/utils/custom_color.dart';
import 'package:compaz_radio/utils/dimsensions.dart';
import 'package:compaz_radio/utils/local_storage.dart';
import 'package:compaz_radio/utils/size.dart';
import 'package:compaz_radio/utils/strings.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);
  final languageController = Get.put(LanguageController());

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int dropdownValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          Strings.settings.tr,
          style: const TextStyle(color: CustomColor.whiteColor),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(),
        child: ListView(
          children: [
            addVerticalSpace(17.8.h),
            _changeThemeWidget(context),
            // Padding(
            //   padding: EdgeInsets.only(
            //     left: 18.8.w,
            //     right: 24.w,
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         Strings.darkModeSelect.tr,
            //         style: TextStyle(
            //           fontSize: Dimensions.settingsScreenFontSize,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //       Center(
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: DropdownButtonHideUnderline(
            //             child: DropdownButton2(
            //                 icon: const Icon(
            //                   Icons.arrow_drop_down,
            //                   // color: Colors.white,
            //                   size: 35,
            //                 ),
            //                 alignment: Alignment.topRight,
            //                 hint: const Center(child: Text("")),
            //                 dropdownWidth: 167.w,
            //                 value: dropdownValue,
            //                 dropdownDecoration: BoxDecoration(
            //                   borderRadius:
            //                   BorderRadius.circular(Dimensions.radius),
            //                   color: Get.isDarkMode
            //                       ? Colors.black
            //                       : CustomColor.primaryColor,
            //                 ),
            //                 items: [
            //                   DropdownMenuItem(
            //                     value: AppThemes.dark,
            //                     child: Text(
            //                       AppThemes.toStr(AppThemes.dark),
            //                       style: TextStyle(
            //                         fontSize:
            //                             Dimensions.settingsScreenDropDownFontSize,
            //                         fontWeight: FontWeight.w500,
            //                       ),
            //                     ),
            //                   ),
            //                   DropdownMenuItem(
            //                     value: AppThemes.light,
            //                     child: Text(
            //                       AppThemes.toStr(AppThemes.light),
            //                       style: TextStyle(
            //                         fontSize:
            //                             Dimensions.settingsScreenDropDownFontSize,
            //                         fontWeight: FontWeight.w500,
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //                 onChanged: (dynamic themeId) async {
            //                   await DynamicTheme.of(context)!.setTheme(themeId);
            //                   setState(() {
            //                     dropdownValue = themeId;
            //                   });
            //                 }),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            addVerticalSpace(11.2.h),
            Obx(
              () => SizedBox(
                height: 50.h,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 18.8.w),
                      child: Text(
                        Strings.changeLanguage.tr,
                        style: TextStyle(
                          fontSize: Dimensions.settingsScreenFontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    //change language
                    Padding(
                      padding: EdgeInsets.only(right: 34.8.w),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          alignment: Alignment.topRight,
                          hint: const Center(child: Text("")),
                          // dropdownWidth: 167.w,
                          value: widget.languageController.locale.value,
                          // dropdownDecoration: BoxDecoration(
                          //   borderRadius:
                          //       BorderRadius.circular(Dimensions.radius),
                          //   color: Get.isDarkMode
                          //       ? Colors.black.withOpacity(0.7)
                          //       : CustomColor.primaryColor.withOpacity(0.7),
                          // ),
                          // icon: const Icon(
                          //   Icons.arrow_drop_down,
                          //   size: 35,
                          // ),
                          items: widget
                              .languageController.optionsLocales.entries
                              .map((item) {
                            return DropdownMenuItem<String>(
                              value: item.key,
                              child: Text(item.value['description'],
                                  style: TextStyle(
                                    fontSize: Dimensions
                                        .settingsScreenDropDownFontSize,
                                    fontWeight: FontWeight.w500,
                                  )),
                            );
                          }).toList(),
                          onChanged: (value) {
                            widget.languageController
                                .updateLocale(value.toString());
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _changeThemeWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 18.8.w,
        right: 24.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Strings.darkModeSelect.tr,
            style: TextStyle(
              fontSize: Dimensions.settingsScreenFontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() => Switch(
                    onChanged: (value) async {
                      await DynamicTheme.of(context)!.setTheme(value ? 1 : 0);
                      widget.languageController.dropdownValue.value = value;
                      LocalStorage.saveTheme(themeStateName: value);
                    },
                    value: widget.languageController.dropdownValue.value,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
