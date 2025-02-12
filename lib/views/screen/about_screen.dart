import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multi_radio/utils/dimsensions.dart';
import 'package:multi_radio/utils/size.dart';
import 'package:multi_radio/widget_helper/image_widget.dart';
import 'package:multi_radio/widget_helper/image_pastor_widget.dart';


import 'package:multi_radio/widget_helper/network_widget_man.dart';
import '../../utils/custom_color.dart';
import '../../utils/strings.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.primaryColor,
        elevation: 0,
        title: Text(
          Strings.aboutUs.tr,
          style: const TextStyle(color: CustomColor.whiteColor),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: CustomColor.primaryBackgroundColor,
        child: ListView(
          children: [
            addVerticalSpace(40.h),
            _iconAndTitle(context),
            _descriptionWidget(context),
            _socialIcons(context),
          ],
        ),
      ),
    );
  }

  _iconAndTitle(BuildContext context) {
    return Column(
      mainAxisAlignment: mainCenter,
      children: [
        const ImagePastorWidget(),
        addVerticalSpace(20.h),
        Container(
          margin: EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 2),
          child: Text(
            Strings.multiRadio.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30),
          ),
        ),
        addVerticalSpace(10.h),
      ],
    );
  }

  _descriptionWidget(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(Dimensions.marginSize * 0.5),
          child: Text(
            Strings.aboutUsDesc,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: Dimensions.textSize,
            )
          ),
        ),
        addVerticalSpace(40.h),
      ],
    );
  }

  _socialIcons(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.marginSize),
      child: const NetworkWidgetMan(),
    );
  }
}
