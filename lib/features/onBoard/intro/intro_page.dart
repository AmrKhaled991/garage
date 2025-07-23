// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:garage/core/controllers/main_controller.dart';
import 'package:garage/core/ui/LoadingWidget.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/widgets/slider_view.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';

import 'intro_controller.dart';

// ignore: must_be_immutable
class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final controller = Get.find<IntroController>();
  var isLastPage = false;

  final state = Get.find<IntroController>().state;

  MainController mainController = Get.find();

  var sliderController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      body: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              const Spacer(),
              SliderView(
                sliderHeight: 0.5.sh,
                autoPlay: false,
                controller: sliderController,
                indicatorColor: colorPrimary,
                onPageChanged: (index) {
                  isLastPage = index == state.intros.value!.data!.length - 1;
                  setState(() {});
                },
                items:
                    state.intros.value?.data?.map((e) {
                      return _introItem(
                        image: e.image,
                        title: e.title,
                        description: e.description,
                      );
                    }).toList(),
              ),
              const Spacer(flex: 1),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    spacing: 8,
                    children: [
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                color: Colors.white,
                                strokeAlign: 1,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 10,
                            ),
                          ),
                          child: Text(
                            isLastPage ? 'skip'.tr : 'next'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Zain',
                              fontWeight: FontWeight.w700,
                              height: 1.50,
                            ),
                          ),
                          onPressed: () {
                            isLastPage
                                ? Get.offAllNamed(Routes.MAIN)
                                : sliderController.nextPage();
                          },
                        ),
                      ),
                      Expanded(
                        child: MyButton(
                          title: "login".tr,
                          isOutline: true,
                          textColor: colorBlack,
                          onClick: () {
                            Get.offAllNamed(Routes.LOGIN);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        }),
      ),
    );
  }

  Widget _introItem({String? image, String? title, String? description}) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyImage(image: image, fit: BoxFit.contain, width: Get.width * 0.7),
          30.verticalSpace,
          Text(
            title ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w800,
              height: 1.20,
            ),
          ).paddingSymmetric(horizontal: 16),
          8.verticalSpace,
          Text(
            description ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFCCCAC7),
              fontSize: 18,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ).paddingSymmetric(horizontal: 16),
        ],
      ),
    );
  }
}
