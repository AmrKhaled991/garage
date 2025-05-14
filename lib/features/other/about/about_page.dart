import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:garage/core/ui/LoadingWidget.dart';
import 'package:garage/features/other/about/about_binding.dart';
import 'package:garage/features/other/about/about_state.dart';
import '../../../core/ui/my_scaffold.dart';
import '../../../theme/styles.dart';
import 'about_controller.dart';

class AboutPage extends StatelessWidget {

  AboutController controller = Get.find<AboutController>();
  AboutState state = Get
      .find<AboutController>()
      .state;


  @override
  Widget build(BuildContext context) {
    return MyScaffold(
        title: "about".tr,
        body: Obx(() {
          return LoadingWidget(
            loadingState: state.about.value,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Html(data: state.about.value.data??"", style: MyTextStyle.htmlSubTitle(color: Colors.black, fontSize: 22),),
            ),
          );
        })
    );
  }
}
