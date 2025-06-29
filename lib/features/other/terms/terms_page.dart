import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:garage/core/ui/LoadingWidget.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/features/other/terms/terms_state.dart';
import 'package:garage/theme/styles.dart';
import 'terms_controller.dart';

class TermsPage extends StatelessWidget {
  TermsController controller = Get.find<TermsController>();
  TermsState state = Get.find<TermsController>().state;

  TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "terms".tr,
      body: Obx(() {
        return LoadingWidget(
          loadingState: state.terms.value,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Html(
              data: state.terms.value.data ?? "",
              style: MyTextStyle.htmlSubTitle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
        );
      }),
    );
  }
}
