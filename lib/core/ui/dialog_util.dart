import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/theme/styles.dart';

enum ActionStyle { normal, destructive, important, important_destructive }

class DialogUtil {
  static Color _normal = Colors.black;
  static Color _destructive = Colors.red;

  /// show the OS Native dialog
  static showOSDialog(
    BuildContext context,
    String title,
    String message,
    String firstButtonText,
    Function firstCallBack, {
    ActionStyle firstActionStyle = ActionStyle.normal,
    String? secondButtonText,
    Function? secondCallback,
    ActionStyle secondActionStyle = ActionStyle.normal,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (Platform.isIOS) {
          return _iosDialog(
            context,
            title,
            message,
            firstButtonText,
            firstCallBack,
            firstActionStyle: firstActionStyle,
            secondButtonText: secondButtonText,
            secondCallback: secondCallback,
            secondActionStyle: secondActionStyle,
          );
        } else {
          return _androidDialog(
            context,
            title,
            message,
            firstButtonText,
            firstCallBack,
            firstActionStyle: firstActionStyle,
            secondButtonText: secondButtonText,
            secondCallback: secondCallback,
            secondActionStyle: secondActionStyle,
          );
        }
      },
    );
  }

  /// show the android Native dialog
  static Widget _androidDialog(
    BuildContext context,
    String title,
    String message,
    String firstButtonText,
    Function firstCallBack, {
    ActionStyle firstActionStyle = ActionStyle.normal,
    String? secondButtonText,
    Function? secondCallback,
    ActionStyle secondActionStyle = ActionStyle.normal,
  }) {
    List<TextButton> actions = [];
    actions.add(
      TextButton(
        child: Text(
          firstButtonText,
          style: TextStyle(
            color:
                (firstActionStyle == ActionStyle.important_destructive ||
                        firstActionStyle == ActionStyle.destructive)
                    ? _destructive
                    : _normal,
            fontWeight:
                (firstActionStyle == ActionStyle.important_destructive ||
                        firstActionStyle == ActionStyle.important)
                    ? FontWeight.bold
                    : FontWeight.normal,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
          firstCallBack();
        },
      ),
    );

    if (secondButtonText != null) {
      actions.add(
        TextButton(
          child: Text(
            secondButtonText,
            style: TextStyle(
              color:
                  (secondActionStyle == ActionStyle.important_destructive ||
                          firstActionStyle == ActionStyle.destructive)
                      ? _destructive
                      : _normal,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            secondCallback?.call();
          },
        ),
      );
    }

    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: actions,
    );
  }

  /// show the iOS Native dialog
  static Widget _iosDialog(
    BuildContext context,
    String title,
    String message,
    String firstButtonText,
    Function firstCallback, {
    ActionStyle firstActionStyle = ActionStyle.normal,
    String? secondButtonText,
    Function? secondCallback,
    ActionStyle secondActionStyle = ActionStyle.normal,
  }) {
    List<CupertinoDialogAction> actions = [];
    actions.add(
      CupertinoDialogAction(
        isDefaultAction: true,
        onPressed: () {
          firstCallback();
        },
        child: Text(
          firstButtonText,
          style: TextStyle(
            fontSize: 16,

            color:
                (firstActionStyle == ActionStyle.important_destructive ||
                        firstActionStyle == ActionStyle.destructive)
                    ? _destructive
                    : _normal,
            fontWeight:
                (firstActionStyle == ActionStyle.important_destructive ||
                        firstActionStyle == ActionStyle.important)
                    ? FontWeight.bold
                    : FontWeight.normal,
          ),
        ),
      ),
    );

    if (secondButtonText != null) {
      actions.add(
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            secondButtonText,
            style: TextStyle(
              fontSize: 16,
              color:
                  (secondActionStyle == ActionStyle.important_destructive ||
                          secondActionStyle == ActionStyle.destructive)
                      ? _destructive
                      : _normal,
              fontWeight:
                  (secondActionStyle == ActionStyle.important_destructive ||
                          secondActionStyle == ActionStyle.important)
                      ? FontWeight.bold
                      : FontWeight.normal,
            ),
          ),
        ),
      );
    }

    return CupertinoAlertDialog(
      title: Text(title, style: TextStyle(color: colorBlack, fontSize: 14)),
      content: Text(message, style: TextStyle(color: colorBlack, fontSize: 16)),
      actions: actions,
    );
  }
}
