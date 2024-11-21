import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math' show pi;

import 'package:confetti/confetti.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/features/home/views/homeview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    super.key,
    required this.url,
    required this.totalPrice,
  });

  final String url;
  final double totalPrice;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late ConfettiController _confettiController;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();

    log(widget.totalPrice.toString(), name: 'totalPrice');
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    _confettiController = ConfettiController(
      duration: const Duration(
        seconds: 1,
      ),
    );
  }

  @override
  void dispose() {
    _controller.future.then(
      (value) => value.clearCache(),
    );
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
          (route) => false,
        );
      },
      child: Scaffold(
        appBar: AppBar(actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeView(),
                ),
                (route) => false,
              );
            },
            icon: const Icon(
              Icons.exit_to_app,
            ),
          )
        ]),
        body: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            log('WebView is loading (progress : $progress%)');
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.google.com/')) {
              log('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            log('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            log('Page started loading: $url');
          },
          onPageFinished: (String url) {
            if (url.startsWith(
                'https://payment.souqalgomlah.com/payment/successResponse')) {
              showAdaptiveDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Stack(
                      children: [
                        Text(
                          context.locale == const Locale('ar')
                              ? ' تمت عملية الدفع بنجاح ونم إضافة '
                                  '${(widget.totalPrice * 0.015).toStringAsFixed(3)} '
                                  ' كاش باك لرصيدك'
                              : 'Payment successful and we have added '
                                  '${(widget.totalPrice * 0.015).toStringAsFixed(3)} '
                                  'cashback to your balance',
                        ),
                        ConfettiWidget(
                          confettiController: _confettiController..play(),
                          colors: const [
                            Colors.green,
                            Colors.blue,
                            Colors.pink,
                            Colors.orange,
                            Colors.purple,
                          ],
                          blastDirection: pi,
                          emissionFrequency: 0.2,
                          numberOfParticles: 20,
                          blastDirectionality: BlastDirectionality.explosive,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeView(),
                            ),
                            (route) => false,
                          );
                        },
                        child: Text(
                          context.locale == const Locale('ar')
                              ? 'العودة للرئيسية'
                              : 'Back to home',
                        ),
                      ),
                    ],
                  );
                },
              );
            }

            if (url.startsWith(
                'https://payment.souqalgomlah.com/payment/errorResponse')) {
              showAdaptiveDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      context.locale == const Locale('ar')
                          ? 'فشلت عملية الدفع'
                          : 'Payment failed',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeView(),
                            ),
                            (route) => false,
                          );
                        },
                        child: Text(
                          context.locale == const Locale('ar')
                              ? 'العودة للرئيسية'
                              : 'Back to home',
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
          gestureNavigationEnabled: true,
          backgroundColor: const Color(0x00000000),
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      },
    );
  }
}
