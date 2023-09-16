import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_flutter/viewModel/web_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Flutter Simple Example')),
        body: Consumer<WebViewModel>(
          builder: (context, provider, child) {
            controller = provider.controller;

            return Stack(
              children: [WebViewWidget(controller: controller)],
            );
          },
        ));
  }
}
