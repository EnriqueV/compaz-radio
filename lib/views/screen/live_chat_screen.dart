import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import '../../utils/custom_color.dart';
import '../../utils/strings.dart';

class LiveChatScreen extends StatelessWidget {
  const LiveChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(
          Strings.liveChatWithRj.tr,
          style: const TextStyle(color: CustomColor.whiteColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: true,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(Uri.parse(Strings.liveChatLink).toString())),
          onWebViewCreated: (InAppWebViewController controller) {
            controller.setOptions(
              options: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  useShouldOverrideUrlLoading: true,
                  mediaPlaybackRequiresUserGesture: false,
                ),
                ios: IOSInAppWebViewOptions(
                  allowsInlineMediaPlayback: true,
                  automaticallyAdjustsScrollIndicatorInsets: true,
                ),
              ),
            );
          },
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
              resources: resources,
              action: PermissionRequestResponseAction.GRANT,
            );
          },
        ),
      ),
    );
  }
}