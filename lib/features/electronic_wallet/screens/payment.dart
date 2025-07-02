import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../cubit/electronic_wallet_cubit.dart';

class PaymentWebViewScreen extends StatefulWidget {
  const PaymentWebViewScreen({super.key, this.url});
  final String? url;
  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            // Navigator.pop(context);
          },
          onWebResourceError: (WebResourceError error) {},
          onUrlChange: (v) {
            if (v.url!.toLowerCase() ==
                'https://accept.paymob.com/unifiedcheckout/payment-status') {
              context.read<ElectronicWalletCubit>().paymentCallBack(context);
            }
            /* print("paymob url :: ${v.url.toString()}");
            if (v.url
                .toString()
                .toLowerCase()
                .contains('api/callback_paytabs')) {
              if (v.url.toString().toLowerCase().contains('status=1')) {
                //! we will send api of Gradulation here !
                successGetBar("payment_done".tr());
              } else {
                errorGetBar("payment_error".tr());
              }

              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.homePageScreenRoute, (route) => false);
            }*/
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url ?? 'https://topbuziness.com/ar'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'payment'.tr(),
          ),
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: WebViewWidget(controller: _controller))));
  }
}
