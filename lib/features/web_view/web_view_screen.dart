
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final int index;
  const WebViewScreen({super.key, required this.url, required this.index});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true; 

  @override
  void initState() {
    super.initState();

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) {
                setState(() {
                  _isLoading = true;
                });
              },
              onPageFinished: (url) {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFfef1f4),
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text(
          widget.index == 0
              ? "Privacy Policy"
              : widget.index == 1
              ? "Terms of Service"
              : "Cookie Policy",
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),

          //  Loading Indicator
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class WebViewScreen extends StatefulWidget {
//   final String url;
//   final int index;
//   const WebViewScreen({super.key, required this.url, required this.index});

//   @override
//   State<WebViewScreen> createState() => _WebViewScreenState();
// }

// class _WebViewScreenState extends State<WebViewScreen> {
//   late final WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller =
//         WebViewController()
//           ..setJavaScriptMode(JavaScriptMode.unrestricted)
//           ..loadRequest(Uri.parse(widget.url));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFFfef1f4),
//         elevation: 0,
//         automaticallyImplyActions: true,
//         foregroundColor: Colors.black,
//         title: Text(
//           widget.index == 0
//               ? "Privacy Policy"
//               : widget.index == 1
//               ? "Terms of Service"
//               : "Cookie Policy",
//         ),
//       ),
//       body: WebViewWidget(controller: _controller),
//     );
//   }
// }
