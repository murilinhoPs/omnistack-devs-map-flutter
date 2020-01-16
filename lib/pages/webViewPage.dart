import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Perfil extends StatefulWidget {
  final url;
  Perfil({Key key, this.url}) : super(key: key);

  @override
  _PerfilState createState() => _PerfilState(url);
}

class _PerfilState extends State<Perfil> {
  final url;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  _PerfilState(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pefil no github',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: this.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
