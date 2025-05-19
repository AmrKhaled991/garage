import 'package:garage/core/controllers/main_controller.dart';
import 'package:garage/core/ui/LoadingWidget.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/widgets/slider_view.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'intro_controller.dart';

class IntroPage extends StatelessWidget {
  final controller = Get.find<IntroController>();
  final state = Get.find<IntroController>().state;
  MainController mainController = Get.find();

  var sliderController = CarouselSliderController();

  var isLastPage = false;

  IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      body: Obx(() {
        return Stack(
          fit: StackFit.expand,
          children: [
            SliderView(
              sliderHeight: 0.8.sh,
              autoPlay: false,
              controller: sliderController,
              indicatorColor: colorPrimary,
              onPageChanged: (index) {
                isLastPage = index == 1;
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: SizedBox(
                  height: 0.2.sh,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                  child: const Text(
                                    'التالي',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'Zain',
                                      fontWeight: FontWeight.w700,
                                      height: 1.50,
                                    ),
                                  ),
                                  onPressed: () {
                                    sliderController.nextPage();
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _introItem({String? image, String? title, String? description}) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
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
