import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:compaz_radio/routes/routes.dart';
import 'package:compaz_radio/utils/custom_color.dart';
import 'package:compaz_radio/utils/dimsensions.dart';
import 'package:compaz_radio/utils/size.dart';
import 'package:compaz_radio/utils/strings.dart';
import 'package:compaz_radio/widget_helper/image_widget.dart';
import 'package:compaz_radio/widget_helper/menu_item_widget.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerScreen extends StatelessWidget {
  DrawerScreen({Key? key}) : super(key: key);

  static String androidAppUrl =
      'https://play.google.com/store/apps/details?id=net.appdevs.kerbonline';
  static String iosAppUrl =
      'https://apps.apple.com/ph/app/kerbonline/id1531759968';

  //share link
  Future<void> share() async {
    await FlutterShare.share(
      title: Strings.multiRadio,
      text: Platform.isAndroid
          ? 'Multi Radio Play Store Link'
          : 'Multi Radio App Store Link',
      linkUrl: Platform.isAndroid ? androidAppUrl : iosAppUrl,
    );
  }

  // Función para abrir el link de donación
  Future<void> _launchDonateUrl() async {
    final Uri url = Uri.parse('https://buy.stripe.com/test_bIY5mRb2sgA4gxy6oo');
    if (!await launchUrl(url)) {
      throw Exception('No se pudo abrir $url');
    }
  }

  // Función para abrir el mapa
  Future<void> _launchMapUrl() async {
    final Uri url = Uri.parse('https://www.google.com/maps/place/Iglesia+Compaz/data=!4m2!3m1!1s0x0:0x80e456429662dcf6?sa=X&ved=1t:2428&ictx=111');
    if (!await launchUrl(url)) {
      throw Exception('No se pudo abrir $url');
    }
  }

  final _dialog = RatingDialog(
    initialRating: 1.0,
    title: const Text(
      Strings.multiRadio,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
    message: const Text(
      'Tap a star to set your rating. Add more description here if you want.',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15),
    ),
    image: Image.asset(
      Strings.splashLogo,
      height: 150.h,
    ),
    submitButtonText: 'Submit',
    onCancelled: () => print('cancelled'),
    onSubmitted: (response) {
      if (response.rating < 3.0) {
      } else {
        StoreRedirect.redirect(
            androidAppId: 'com.appdevs.net.multi_radio',
            iOSAppId: 'com.appdevs.net.multi_radio');
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: CustomColor.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30.r)),
      ),
      child: ListView(
        children: [
          _headerDrawer(context),
          Divider(
            height: 2.h,
            color: CustomColor.whiteColor.withOpacity(0.5),
          ),
          _listWidget(context),
        ],
      ),
    );
  }

  _headerDrawer(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.defaultPaddingSize),
      child: Column(
        mainAxisAlignment: mainEnd,
        crossAxisAlignment: crossCenter,
        children: const [ImageWidget()],
      ),
    );
  }

  _listWidget(BuildContext context) {
    return Column(
      children: [
        MenuItemWidget(
          screenName: Strings.liveChatWithRj.tr,
          icon: Icons.chat,
          onPressed: () {
            Get.toNamed(Routes.liveChatScreen);
          },
        ),
        MenuItemWidget(
          screenName: Strings.aboutUs.tr,
          icon: Icons.info,
          onPressed: () {
            Get.toNamed(Routes.aboutScreen);
          },
        ),
      /*  MenuItemWidget(
          screenName: Strings.settings.tr,
          icon: Icons.settings,
          onPressed: () {
            Get.toNamed(Routes.settingsScreen);
          },
        ),
       */
        MenuItemWidget(
          screenName: Strings.share.tr,
          icon: Icons.share,
          onPressed: () {
            share();
          },
        ),
        MenuItemWidget(
          screenName: Strings.rateUs.tr,
          icon: Icons.star_half,
          onPressed: () {
            showDialog(context: context, builder: (context) => _dialog);
          },
        ),
        // Nuevos botones añadidos
        MenuItemWidget(
          screenName: 'Donar',
          icon: Icons.monetization_on,
          onPressed: _launchDonateUrl,
        ),
        MenuItemWidget(
          screenName: 'Cómo Llegar',
          icon: Icons.location_on,
          onPressed: _launchMapUrl,
        ),
      ],
    );
  }
}