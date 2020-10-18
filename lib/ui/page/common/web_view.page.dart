import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/ui/widget/p_loader.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String link;
  final String title;

  const WebViewPage({Key key, this.link, this.title}) : super(key: key);
  static MaterialPageRoute getRoute(String link, {String title}) {
    return MaterialPageRoute(builder: (_) => WebViewPage(link: link, title: title));
  }

  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewPage> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ""),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Stack(
            children: <Widget>[
              WebView(
                initialUrl: widget.link,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  print('Web view compleeted');
                  _controller.complete(webViewController);
                },
                javascriptChannels: <JavascriptChannel>[
                  _toasterJavascriptChannel(context),
                ].toSet(),
                navigationDelegate: (NavigationRequest request) {
                  // if (request.url.startsWith('https://www.youtube.com/')) {
                  //   print('blocking navigation to $request}');
                  //   return NavigationDecision.prevent;
                  // }
                  print('allowing navigation to $request');
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  setState(() {
                    loading = true;
                  });
                  print('Page started loading');
                },
                onPageFinished: (String url) {
                  setState(() {
                    loading = false;
                  });
                  print('Page finished loading: $url');
                },
                gestureNavigationEnabled: true,
              ),
              Align(
                alignment: Alignment.center,
                child: loading ? Ploader() : Container(),
              )
            ],
          );
        },
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Message',
      onMessageReceived: (JavascriptMessage message) {
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      },
    );
  }
}
