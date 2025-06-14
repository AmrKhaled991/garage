import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:progress_indicators/progress_indicators.dart';

class AppLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        child: HeartbeatProgressIndicator(
          child: Image.asset("assets/images/logo.png", height: 60, width: 60),
        ),
      ),
    );
  }
}
