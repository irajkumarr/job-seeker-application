import 'package:flutter/material.dart';
import 'package:frontend/core/utils/device/device_utility.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
        child: Material(
          child: AppBar(
            title: Image.asset("assets/images/content/rojgari_logo.png"),
          ),
        ),
      ),
    );
  }
}
