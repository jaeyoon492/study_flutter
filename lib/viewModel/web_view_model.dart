import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewModel with ChangeNotifier {
  late final WebViewController _controller;
  WebViewController get controller => _controller;

  WebViewModel() {
    _initLoad();
  }

  Future<void> _initLoad() async {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://land-dev.altava.com'));
    notifyListeners();
  }
}
