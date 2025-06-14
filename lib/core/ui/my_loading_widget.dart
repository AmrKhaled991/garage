import 'package:garage/theme/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';

class MyLoadingWidget extends StatelessWidget {
  final bool withPadding;
  const MyLoadingWidget({this.withPadding = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      alignment: Alignment.center,
      margin:
          withPadding
              ? EdgeInsets.only(top: Get.height / 4)
              : const EdgeInsets.all(16),
      child:
      // const CupertinoActivityIndicator(
      //   radius: 30,
      // )
      Lottie.asset('assets/lottie/loading.json'),

      // const LoadingIndicator(
      //     indicatorType: Indicator.ballPulseSync, /// Required, The loading type of the widget
      //     colors: [Colors.red,
      //       Colors.orange,
      //       Colors.yellow,
      //       Colors.green,
      //       Colors.blue,
      //       Colors.indigo,
      //       Colors.purple,],       /// Optional, The color collections
      //       strokeWidth: 4.0,
      // ),
    );
  }
}
