import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class RechargeWebViewScreen extends StatefulWidget {
  final String url;

  const RechargeWebViewScreen(this.url, {super.key});

  @override
  State<RechargeWebViewScreen> createState() => _RechargeWebViewScreenState();
}

class _RechargeWebViewScreenState extends State<RechargeWebViewScreen> {
  double _progress = 0;
  double fem = 1;
  late InAppWebViewController inAppWebViewController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var isLastPage = await inAppWebViewController.canGoBack();
        if (isLastPage) {
          inAppWebViewController.goBack();
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                onWebViewCreated: (InAppWebViewController controller) {
                  inAppWebViewController = controller;
                },
                onLoadStop:
                    (InAppWebViewController controller, Uri? url) async {
                  if (url.toString().contains('vnp_ResponseCode=00')) {
                    Navigator.pop(context);
                    Navigator.pop(context);

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Nạp tiền thành công',
                            style: TextStyle(
                              fontSize: 22 * fem,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  fontSize: 22 * fem,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }

                  if (url.toString().contains('vnp_ResponseCode=24') ||
                      url.toString().contains('vnp_ResponseCode=01') ||
                      url.toString().contains('vnp_ResponseCode=02') ||
                      url.toString().contains('vnp_ResponseCode=03') ||
                      url.toString().contains('vnp_ResponseCode=04') ||
                      url.toString().contains('vnp_ResponseCode=08') ||
                      url.toString().contains('vnp_ResponseCode=79') ||
                      url.toString().contains('vnp_ResponseCode=97')) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Nạp tiền thất bại',
                            style: TextStyle(
                              fontSize: 22 * fem,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  fontSize: 22 * fem,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                onProgressChanged:
                    (InAppWebViewController controller, int process) {
                  setState(() {
                    _progress = process / 100;
                  });
                },
                onLoadError: (InAppWebViewController controller, Uri? url,
                    int code, String message) {},
              ),
              _progress < 1
                  ? LinearProgressIndicator(
                      value: _progress,
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
