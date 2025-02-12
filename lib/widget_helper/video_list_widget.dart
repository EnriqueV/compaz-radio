import 'package:flutter/material.dart';
import 'package:compaz_radio/utils/size.dart';
import '../utils/dimsensions.dart';

class VideoListWidget extends StatelessWidget {
  const VideoListWidget({
    Key? key,
    required this.path,
    required this.title,
    required this.boxFit,
    this.child,
    this.width,
    this.height,
    this.onTap,
    this.borderRadius,
  }) : super(key: key);
  final String path;
  final String title;
  final BoxFit boxFit;
  final double? width;
  final double? height;
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.2,
            width: MediaQuery.sizeOf(context).width,
            margin: EdgeInsets.only(
              bottom: Dimensions.heightSize * 0.4,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: borderRadius ??
                  BorderRadius.circular(Dimensions.radius * 1.5),
              image: DecorationImage(
                image: AssetImage(
                  path,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              title,
               style: Theme.of(context).textTheme.titleMedium
            ),
          ),
          addVerticalSpace(Dimensions.heightSize * 1.2)
        ],
      ),
    );
  }
}
