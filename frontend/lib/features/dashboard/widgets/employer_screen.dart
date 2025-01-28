import 'package:flutter/material.dart';
import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EmployerScreen extends StatefulWidget {
  const EmployerScreen({super.key});

  @override
  State<EmployerScreen> createState() => _EmployerScreenState();
}

class _EmployerScreenState extends State<EmployerScreen> {
  late final WebViewController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (String url) {
          setState(() {
            isLoading = true;
          });
        },
        onPageFinished: (String url) {
          setState(() {
            isLoading = false;
          });
        },
      ))
      ..loadRequest(Uri.parse('https://rojgari.com/en/employer-zone/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.white,
      body: Padding(
        padding: EdgeInsets.only(top: KSizes.spaceBtwSections),
        child: Stack(
          children: [
            Container(
              color: KColors.white,
              child: WebViewWidget(
                controller: controller,
              ),
            ),
            if (isLoading)
              Container(
                height: KDeviceUtils.getScreenHeight(context),
                color: KColors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomLoading(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
