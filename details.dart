import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class Details extends StatefulWidget {
  final String url;

  Details(this.url);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late String finalUrl;
 late WebViewController controller;

  @override
  void initState() {

    if (widget.url.startsWith("http://")) {
      finalUrl = widget.url.replaceFirst("http://", "https://");
    } else {
      finalUrl = widget.url;
    }
    super.initState();
    controller = WebViewController()
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
      ..loadRequest(Uri.parse(finalUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


      ),
      body: Container(
        child: WebViewWidget(controller: controller,),
      )
    );
  }
}
