import 'package:flutter/material.dart';
import 'package:compaz_radio/utils/size.dart';
import '../utils/dimsensions.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            // Agregar un pequeño delay para evitar problemas de autenticación
            Future.delayed(Duration(milliseconds: 100), onTap);
          }
        },
        borderRadius: (borderRadius as BorderRadius?) ?? BorderRadius.circular(Dimensions.radius * 1.5),
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
              ),
              child: ClipRRect(
                borderRadius: borderRadius ??
                    BorderRadius.circular(Dimensions.radius * 1.5),
                child: path.startsWith('http') || path.startsWith('https')
                    ? CachedNetworkImage(
                        imageUrl: path,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300],
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: Icon(Icons.error),
                        ),
                      )
                    : Image.asset(
                        path,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: Icon(Icons.error),
                          );
                        },
                      ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            addVerticalSpace(Dimensions.heightSize * 1.2)
          ],
        ),
      ),
    );
  }
}