import 'package:flutter/material.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/core/ui/MyLoadingButton.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/features/auth/company_profile_edit/company_profile_edit_Settings/company_profile_edit_indicator.dart';
import 'package:garage/features/auth/company_profile_edit/company_profile_edit_Settings/company_profile_edit_view2.dart';
import 'package:garage/features/auth/company_profile_edit/company_profile_edit_Settings/company_profile_edit_view1.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class CompanyProfileEditPage extends StatefulWidget {
  const CompanyProfileEditPage({super.key});

  @override
  State<CompanyProfileEditPage> createState() => _CompanyProfileEditPageState();
}

class _CompanyProfileEditPageState extends State<CompanyProfileEditPage> {
  late PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: CompanyProfileEditIndicator(currentPage: currentPage),
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                children: [
                  CompanyProfileEditView1(),
                  const CompanyProfileEditView2(),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      fab: Container(
        padding: const EdgeInsets.all(16.0),
        child:
            currentPage == 0
                ? MyButton(
                  title: "next".tr,
                  onClick: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.linear,
                    );
                  },
                )
                : MyLoadingButton(
                  title: "done".tr,
                  onClick: (RoundedLoadingButtonController _controller) {
                    _controller.success();
                    Future.delayed(const Duration(seconds: 1), () {
                      Get.offAllNamed(Routes.LOGIN);
                    });
                  },
                ),
      ),
    );
  }
}
