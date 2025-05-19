import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:octo_image/octo_image.dart';
import 'package:url_launcher/url_launcher.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class Utils {
  static String getErrorFromJson(Map<String, dynamic>? json) {
    print("getErrorFromJson: $json");
    var buffer = StringBuffer();
    if (json == null) {
      buffer.write("Unknown error");
      return buffer.toString();
    }
    if (json["errors"] != null) {
      Map<String, dynamic> errors = json["errors"];
      errors.forEach((key, value) {
        for (var element in (value as List)) {
          buffer.write(element + "\n");
        }
      });
    }

    if (buffer.toString().isEmpty) {
      if (json["message"] != null) {
        buffer.write(json["message"]);
      }
      if (json["msg"] != null) {
        buffer.write(json["msg"]);
      }
    }
    return buffer.toString();
  }

  static showSnackBar(String message) {
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        backgroundColor: colorBlack,
        borderRadius: 10,
        isDismissible: true,

        margin: const EdgeInsets.symmetric(horizontal: 20),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static showCartSnackBar({String? message}) {
    Get.showSnackbar(
      GetSnackBar(
        message: message ?? "item_added_to_cart".tr,
        backgroundColor: colorBlack,
        borderRadius: 10,
        isDismissible: true,

        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        mainButton: TextButton(
          onPressed: () {
            Get.toNamed(Routes.CART);
          },
          child: Text("show_cart".tr, style: MyTextStyle.myBlackTitle),
        ),
      ),
    );
  }

  // static Future<dynamic> navigate(
  //     BuildContext context, Widget widget,
  //     {bool fullscreenDialog = false}) async {
  //   Widget w = await Future.microtask(() {
  //     return widget;
  //   });
  //   return Navigator.of(context).push(
  //     CupertinoPageRoute(
  //         builder: (c) => CupertinoScaffold(body: w), fullscreenDialog: fullscreenDialog),
  //   );
  // }
  //
  // static Future<dynamic> navigateAndRemoveUntil(
  //     BuildContext context, Widget widget,
  //     {bool fullscreenDialog = false}) async {
  //   Widget w = await Future.microtask(() {
  //     return widget;
  //   });
  //   return Navigator.of(context).pushAndRemoveUntil(
  //     CupertinoPageRoute(
  //         builder: (c) => CupertinoScaffold(body: w), fullscreenDialog: fullscreenDialog),
  //     (b) => false,
  //   );
  // }

  static void showSheet(
    BuildContext context,
    Widget widget, {
    bool isScrollable = false,
    double height = 0.5,
  }) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAlias,
      // showDragHandle: true,
      backgroundColor: colorBlack,
      isScrollControlled: isScrollable,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return Container(
          height: Get.height * height,
          padding: MediaQuery.of(context).viewInsets,
          child: widget,
        );
      },
    );

    // if(isScrollable){
    //   showCupertinoModalBottomSheet(
    //     context: context,
    //     // expand: true,
    //     // duration: Duration(milliseconds: 600),
    //     backgroundColor: Colors.transparent,
    //     builder: (context) => w,
    //   );
    // }else {
    //   CupertinoScaffold.showCupertinoModalBottomSheet(
    //     context: context,
    //     // expand: true,
    //     // duration: Duration(milliseconds: 600),
    //     backgroundColor: Colors.transparent,
    //     builder: (context) => w,
    //   );
    // }
  }

  static Future<void> customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  static OctoProgressIndicatorBuilder myOctoProgressIndicator() {
    return (context, progress) {
      double? value;
      if (progress != null && progress.expectedTotalBytes != null) {
        value = progress.cumulativeBytesLoaded / progress.expectedTotalBytes!;
      }
      return Center(
        child: Lottie.asset('assets/lottie/loading.json', width: 100),
      );
    };
  }
}

extension FirstItemOrNullExtension<E> on Iterable<E> {
  E? firstItemOrNull(bool Function(E) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension EmailValidator on String? {
  bool isValidEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this ?? "");
  }
}
