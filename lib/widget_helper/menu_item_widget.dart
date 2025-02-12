import 'package:flutter/material.dart';
import 'package:compaz_radio/utils/custom_color.dart';
import 'package:compaz_radio/utils/dimsensions.dart';


class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({Key? key, required this.screenName, required this.icon, required this.onPressed}) : super(key: key);

  final String screenName;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: CustomColor.whiteColor.withOpacity(0.5),
      child: Padding(
        padding:
        EdgeInsets.symmetric(vertical: Dimensions.defaultPaddingSize * 0.5),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                icon,
                size: 30,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                screenName,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
