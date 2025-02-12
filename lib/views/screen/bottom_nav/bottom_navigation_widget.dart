import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:compaz_radio/utils/strings.dart';
import 'package:compaz_radio/views/screen/bottom_nav/video_list_screen.dart';

import '../../../controller/bottom_nav_bar_controller.dart';
import '../../../utils/custom_color.dart';
import '../../../utils/dimsensions.dart';
import '../../../utils/size.dart';
import '../drawer_screen.dart';
import '../radio_list_screen.dart';

class BottomNavigationWidget extends StatelessWidget {
  BottomNavigationWidget({Key? key}) : super(key: key);

  final controller = Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    final List body = [
      RadioListScreen(),
      VideoListScreen(),
    ];
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        drawer: DrawerScreen(),
        extendBody: false,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: CustomColor.primaryBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            controller.selectedIndex.value == 0
                ? Strings.radio.tr
                : controller.selectedIndex.value == 1
                    ? Strings.video.tr
                    : "",
            style: const TextStyle(
                color: CustomColor.primaryColor, fontWeight: FontWeight.w500),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                  icon: Icon(
                    Icons.menu,
                    color: CustomColor.primaryColor,
                  ));
            },
          ),
        ),
        body: Obx(
          () => body[controller.selectedIndex.value],
        ),
        bottomNavigationBar: BottomAppBar(
          clipBehavior: Clip.antiAlias,
          surfaceTintColor: Colors.transparent,
          height: Dimensions.heightSize * 6.3,
          elevation: 0,
          shape: const CircularNotchedRectangle(),
          notchMargin: 2,
          color: CustomColor.primaryBackgroundColor,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.widthSize * 2,
            ),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomItemWidget(
                      icon: Icons.radio, label: Strings.radio, index: 0),
                  addHorizontalSpace(Dimensions.widthSize * 5),
                  BottomItemWidget(
                    icon: Icons.video_collection,
                    label: Strings.video,
                    index: 1,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class BottomItemWidget extends StatelessWidget {
  BottomItemWidget({super.key, this.icon, required this.label, this.index});
  final IconData? icon;
  final String label;
  final int? index;
  final controller = Get.put(BottomNavigationController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.selectedIndex.value = index!;
      },
      child: Obx(() => SizedBox(
            width: Dimensions.widthSize * 10,
            child: Column(
              children: [
                addVerticalSpace(Dimensions.heightSize * 0.2),
                Icon(icon,
                    size: 26.r,
                    color: controller.selectedIndex.value == index
                        ? CustomColor.primaryColor
                        : CustomColor.whiteColor),
                addVerticalSpace(Dimensions.heightSize * 0.1),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: Dimensions.scheduleSubtitleTextSize,
                    color: controller.selectedIndex.value == index
                        ? CustomColor.primaryColor
                        : CustomColor.whiteColor,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
