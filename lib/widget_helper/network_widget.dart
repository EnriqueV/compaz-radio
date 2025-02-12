import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_radio/utils/size.dart';
import 'package:url_launcher/url_launcher.dart';

class NetworkWidget extends StatelessWidget {
  const NetworkWidget({Key? key}) : super(key: key);

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
            color: Theme.of(context).primaryColor,
          ),
        ),
        addHorizontalSpace(22.3.w),
        GestureDetector(
          onTap: () {
            // ignore: deprecated_member_use
            launch('https://www.instagram.com/iglesiacompaz?igsh=c29hOGMzNDM4czNk');
          },
          child: Image.asset(
            "assets/images/instagram.png",
            height: 50.h,
            color: Theme.of(context).primaryColor,
          ),
        ),
        addHorizontalSpace(22.8.w),
        GestureDetector(
          onTap: () {
            // ignore: deprecated_member_use
            launch('https://x.com/iglesiacompaz?s=21');
          },
          child: Image.asset(
            "assets/images/twitter.png",
            height: 50.h,
            color: Theme.of(context).primaryColor,
          ),
        ),
        addHorizontalSpace(22.8.w),
        // Nuevo botón de WhatsApp
        GestureDetector(
          onTap: () {
            // Reemplaza el número con el que desees usar
            launch('https://wa.me/+50370575658');
          },
          child: Image.asset(
            "assets/images/what.png", // Asegúrate de tener esta imagen en tu carpeta assets
            height: 50.h,
            color: Theme.of(context).primaryColor,
          ),
        ),
        addHorizontalSpace(22.8.w),
        // Nuevo botón para el sitio web
        GestureDetector(
          onTap: () {
            // Reemplaza con tu URL
            launch('https://www.iglesiacompaz.com/');
          },
          child: Image.asset(
            "assets/images/web.png", // Asegúrate de tener esta imagen en tu carpeta assets
            height: 50.h,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}