import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_radio/utils/custom_color.dart';
import 'package:multi_radio/utils/size.dart';
import 'package:url_launcher/url_launcher.dart';

class NetworkWidgetMan extends StatelessWidget {
  const NetworkWidgetMan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainCenter,
      children: [
        GestureDetector(
          onTap: () {
            // ignore: deprecated_member_use
            launch('https://www.facebook.com/share/1DeWyxJJ5S/?mibextid=wwXIfr');
          },
          child: Image.asset(
            "assets/images/facebook.png",
            height: 50.h,
            color: CustomColor.darkPrimaryColor,
          ),
        ),
        addHorizontalSpace(22.3.w),
        GestureDetector(
          onTap: () {
            // ignore: deprecated_member_use
            launch('https://www.instagram.com/pastorvladimir.sv?igsh=MThkamhtdGx6and3Yg==');
          },
          child: Image.asset(
            "assets/images/instagram.png",
            height: 50.h,
            color: CustomColor.darkPrimaryColor,
          ),
        ),
        addHorizontalSpace(22.8.w),
        GestureDetector(
          onTap: () {
            // ignore: deprecated_member_use
            launch('https://x.com/pastorvladimir?s=21');
          },
          child: Image.asset(
            "assets/images/twitter.png",
            height: 50.h,
            color:CustomColor.darkPrimaryColor,
          ),
        ),
        addHorizontalSpace(22.8.w),
        // Nuevo botón para el sitio web
        GestureDetector(
          onTap: () {
            // Reemplaza con tu URL
            launch('https://vladimirrivas.com');
          },
          child: Image.asset(
            "assets/images/web.png", // Asegúrate de tener esta imagen en tu carpeta assets
            height: 50.h,
            color: CustomColor.darkPrimaryColor,
          ),
        ),
      ],
    );
  }
}