import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/features/auth/login/widgets/login_form_section.dart';
import 'package:garage/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Column(
            children: [
              const Center(
                child: MyImage(image: "assets/images/logo2.png", height: 100),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 60),
                    Text(
                      "login".tr,
                      textAlign: TextAlign.center,
                      style: MyTextStyle.myPrimaryBoldLargeTitle.copyWith(
                        fontSize: 30,
                        fontFamily: 'Zain',
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "login_hint".tr,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: MyTextStyle.myGreySubTitle,
                    ),
                    const SizedBox(height: 9),
                    loginFormSection(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
