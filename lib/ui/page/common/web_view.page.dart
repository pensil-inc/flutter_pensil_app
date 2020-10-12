// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:webview_flutter/webview_flutter.dart';

// class WebViewPage extends StatefulWidget {
//   final String link;

//   const WebViewPage({Key key, this.link}) : super(key: key);
//   @override
//   _WebViewExampleState createState() => _WebViewExampleState();
// }

// class _WebViewExampleState extends State<WebViewPage> {
//   final Completer<WebViewController> _controller =
//       Completer<WebViewController>();
//   bool loading = true;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           // title: const Text('Flutter WebView example'),

//           ),
//       body: Builder(
//         builder: (BuildContext context) {
//           return Stack(
//             children: <Widget>[
//               WebView(
//                 initialUrl: widget.link,
//                 javascriptMode: JavascriptMode.unrestricted,
//                 onWebViewCreated: (WebViewController webViewController) {
//                   print('Web view compleeted');
//                   _controller.complete(webViewController);
//                 },
//                 javascriptChannels: <JavascriptChannel>[
//                   _toasterJavascriptChannel(context),
//                 ].toSet(),
//                 navigationDelegate: (NavigationRequest request) {
//                   // if (request.url.startsWith('https://www.youtube.com/')) {
//                   //   print('blocking navigation to $request}');
//                   //   return NavigationDecision.prevent;
//                   // }
//                   print('allowing navigation to $request');
//                   return NavigationDecision.navigate;
//                 },
//                 onPageStarted: (String url) {
//                   setState(() {
//                     loading = true;
//                   });
//                   print('Page started loading');
//                 },
//                 onPageFinished: (String url) {
//                   setState(() {
//                     loading = false;
//                   });
//                   print('Page finished loading: $url');
//                 },
//                 gestureNavigationEnabled: true,
//               ),
//               Align(
//                 alignment: Alignment.center,
//                 child: loading
//                     ? InstrumentsIndicator(color: Colors.black54)
//                     : Container(),
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }

//   JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
//     return JavascriptChannel(
//       name: 'Message',
//       onMessageReceived: (JavascriptMessage message) {
//         Scaffold.of(context).showSnackBar(
//           SnackBar(content: Text(message.message)),
//         );
//       },
//     );
//   }
// }
