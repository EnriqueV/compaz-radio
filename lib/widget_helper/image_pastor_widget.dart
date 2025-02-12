import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:compaz_radio/utils/custom_color.dart';
import 'package:compaz_radio/utils/strings.dart';

class ImagePastorWidget extends StatelessWidget {
  const ImagePastorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      height: 300.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: CustomColor.whiteColor,
          boxShadow: const [
            BoxShadow(
              color: CustomColor.whiteColor,
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
          image: const DecorationImage(
            image: AssetImage(Strings.pastor),
            fit: BoxFit.fill,
          )),
    );
  }
}
