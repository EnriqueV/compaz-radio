import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoStreamingScreen extends StatefulWidget {
  final String embedUrl;
  const VideoStreamingScreen({super.key, required this.embedUrl});

  @override
  State<VideoStreamingScreen> createState() => _VideoStreamingScreenState();
}

class _VideoStreamingScreenState extends State<VideoStreamingScreen> {
  late final WebViewController controller;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    try {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.black)
        ..enableZoom(false)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {
              if (mounted) {
                setState(() {
                  isLoading = true;
                  errorMessage = null;
                });
              }
            },
            onPageFinished: (String url) {
              if (mounted) {
                setState(() {
                  isLoading = false;
                });
              }
            },
            onWebResourceError: (WebResourceError error) {
              if (mounted) {
                setState(() {
                  isLoading = false;
                  errorMessage = 'Error al cargar el video: ${error.description}';
                });
              }
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.embedUrl));
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
          errorMessage = 'Error al inicializar el video: $e';
        });
      }
    }
  }

  @override
  void dispose() {
    try {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    } catch (e) {
      print('Error resetting orientation: $e');
    }
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    try {
      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    } catch (e) {
      print('Error resetting orientation on pop: $e');
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          centerTitle: true,
          title: Text('Video'.tr),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              await _onWillPop();
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              if (errorMessage == null)
                WebViewWidget(controller: controller)
              else
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 48, color: Colors.red),
                      SizedBox(height: 16),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          errorMessage!,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                            errorMessage = null;
                          });
                          _initializeWebView();
                        },
                        child: Text('Reintentar'),
                      ),
                    ],
                  ),
                ),
              if (isLoading)
                Container(
                  color: Colors.black54,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}