import 'dart:ui';

import 'package:flutter/material.dart';
import 'loader.component.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Center(
          child: Container(height: 70, width: 70, child: AppLoader()),
        ),
      );
    },
  );
}
