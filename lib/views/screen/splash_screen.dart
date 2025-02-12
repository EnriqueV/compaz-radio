import 'package:flutter/material.dart';
import 'package:compaz_radio/utils/custom_color.dart';
import 'package:compaz_radio/utils/dimsensions.dart';
import 'package:compaz_radio/utils/size.dart';
import 'package:compaz_radio/utils/strings.dart';
import 'package:compaz_radio/widget_helper/image_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: mainSpaceBet,
          children: [
            Container(),
            Column(
              crossAxisAlignment: crossCenter,
              children: const [ImageWidget()],
            ),
            Column(
              crossAxisAlignment: crossCenter,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.defaultPaddingSize),
                  child: CircularProgressIndicator(
                    color: CustomColor.primaryColor,
                    backgroundColor: CustomColor.gray.withOpacity(0.5),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Dimensions.defaultPaddingSize * 0.5),
                  child: const Text(
                    Strings.version,
                    style: TextStyle(
                      color: CustomColor.whiteColor,
                      fontSize: 10,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
