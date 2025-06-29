import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:garage/routes/arguments.dart';
import 'package:garage/theme/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebviewPaymentPage extends StatefulWidget {
  String? url;

  WebviewPaymentPage({super.key}) {
    url = Get.arguments?[MyArguments.URL];
  }

  @override
  _WebviewPaymentPageState createState() => _WebviewPaymentPageState();
}

class _WebviewPaymentPageState extends State<WebviewPaymentPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  WebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    _webViewController =
        WebViewController.fromPlatformCreationParams(params)
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                debugPrint('WebView is loading (progress : $progress%)');
              },
              onPageStarted: (String url) {
                debugPrint('Page started loading: $url');
              },
              onPageFinished: (String url) async {
                String? html =
                    await _webViewController?.runJavaScriptReturningResult(
                          "document.documentElement.innerText",
                        )
                        as String?;
                print("finished url: $url \n html: $html");
                if (html == null) {
                  return;
                }
                try {
                  Map<String, dynamic>? json =
                      (Platform.isIOS)
                          ? jsonDecode(html)
                          : jsonDecode(jsonDecode(html));
                  print("finished url: $url \n json: $json");
                  if (json != null && json.containsKey("key")) {
                    print("json.key: ${json["key"]}");
                    Get.back(result: json);
                  }
                } catch (e) {
                  print("parsing json error");
                  e.printError();
                }
              },
              onWebResourceError: (WebResourceError error) {
                debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.url ?? ""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text("payment".tr, style: MyTextStyle.normalStyle),
        border: const Border.fromBorderSide(BorderSide.none),
        backgroundColor: Colors.white,
      ),
      backgroundColor: colorOffWhite,
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) {
            return;
          }
          Get.back();
        },
        child: WebViewWidget(controller: _webViewController!),
      ),
    );
  }
}
