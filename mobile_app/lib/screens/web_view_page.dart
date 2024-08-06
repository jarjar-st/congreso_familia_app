import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FormWebViewPage extends StatefulWidget {
  const FormWebViewPage({super.key});

  @override
  _FormWebViewPageState createState() => _FormWebViewPageState();
}

class _FormWebViewPageState extends State<FormWebViewPage> {
  late final WebViewController _controller;
  bool _isPageLoaded = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              _isPageLoaded = true;
            });
            _controller.runJavaScript("setTimeout(function() {"
                "document.querySelector('header').style.display = 'none';" // Oculta el header
                "document.querySelector(':where(.wp-site-blocks) > :first-child').style.display = 'none';" // Oculta el footer
                "document.querySelector('.ocultar-primero').style.display = 'none';" // Oculta el elemento con la clase 'ocultar-primero'
                "}, 1000);"); // Espera 1 segundo antes de ejecutar el código
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://congresodelafamiliahn.com/2024congreso/registro-app/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isPageLoaded
          ? WebViewWidget(controller: _controller)
          : Center(child: CircularProgressIndicator()),
    );
  }
}
