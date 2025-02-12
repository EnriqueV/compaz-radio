import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import '../../utils/custom_color.dart';
import '../../utils/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveChatScreen extends StatefulWidget {
  const LiveChatScreen({Key? key}) : super(key: key);

  @override
  State<LiveChatScreen> createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {
  final GlobalKey webViewKey = GlobalKey();
  bool isLoading = true;
  double progress = 0;
  InAppWebViewController? webViewController;
  String? loadError;
  final String chatUrl = 'https://my.cbox.ws/compaz';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.primaryColor,
        elevation: 0,
        title: Text(
          Strings.liveChatWithRj.tr,
          style: const TextStyle(color: CustomColor.whiteColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.open_in_browser, color: CustomColor.whiteColor),
            onPressed: () async {
              final Uri url = Uri.parse(chatUrl);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh, color: CustomColor.whiteColor),
            onPressed: () {
              webViewController?.reload();
            },
          ),
        ],
      ),
      body: SafeArea(
        bottom: true,
        child: Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(
                url: WebUri(chatUrl),
                method: 'GET',
                headers: {
                  'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
                  'Accept-Language': 'en-US,en;q=0.5',
                  'Connection': 'keep-alive',
                  'Upgrade-Insecure-Requests': '1',
                  'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1',
                },
              ),
              initialSettings: InAppWebViewSettings(
                mediaPlaybackRequiresUserGesture: false,
                allowsInlineMediaPlayback: true,
                javaScriptEnabled: true,
                domStorageEnabled: true,
                databaseEnabled: true,
                useWideViewPort: true,
                safeBrowsingEnabled: true,
                mixedContentMode: MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
                cacheEnabled: true,
                userAgent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1',
                preferredContentMode: UserPreferredContentMode.MOBILE,
              ),
              onWebViewCreated: (controller) {
                webViewController = controller;
                print("WebView creado");
              },
              onLoadStart: (controller, url) {
                print("Iniciando carga: ${url?.toString()}");
                setState(() {
                  isLoading = true;
                });
              },
              onLoadStop: (controller, url) {
                print("Carga completada: ${url?.toString()}");
                setState(() {
                  isLoading = false;
                });
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                print("Intentando cargar URL: ${navigationAction.request.url}");
                return NavigationActionPolicy.ALLOW;
              },
              onProgressChanged: (controller, progress) {
                setState(() {
                  this.progress = progress / 100;
                });
                print("Progreso: ${progress}%");
              },
              onReceivedError: (controller, request, error) {
                print("Error: ${error.toString()}");
                setState(() {
                  isLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error al cargar el chat. ¿Deseas abrirlo en el navegador?'),
                    action: SnackBarAction(
                      label: 'Abrir',
                      onPressed: () async {
                        final Uri url = Uri.parse(chatUrl);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        }
                      },
                    ),
                  ),
                );
              },
            ),
            if (isLoading)
              Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: progress,
                        valueColor: AlwaysStoppedAnimation<Color>(CustomColor.primaryColor),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Cargando chat... ${(progress * 100).toInt()}%',
                        style: TextStyle(color: CustomColor.primaryColor),
                      ),
                      TextButton(
                        onPressed: () async {
                          final Uri url = Uri.parse(chatUrl);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url, mode: LaunchMode.externalApplication);
                          }
                        },
                        child: Text('Abrir en navegador'),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}