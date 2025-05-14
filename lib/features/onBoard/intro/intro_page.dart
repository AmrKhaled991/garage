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
  final state = Get
      .find<IntroController>()
      .state;
  MainController mainController = Get.find();

  var sliderController = CarouselSliderController();

  var isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          return LoadingWidget(
            loadingState: state.intros.value,
            loadingOnly: true,
            child: Stack(
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
                  items: state.intros.value?.data?.map((e) {
                    return _introItem(
                        image: e.image,
                        title: e.title,
                        description: e.description
                    );
                  },).toList()
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Container(
                      height: 0.2.sh,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                              color: colorSecondary,
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: MyImage(image: "assets/images/ic_next.svg"),
                                    onPressed: () {
                                      if (isLastPage) {
                                        Get.offAllNamed(Routes.MAIN);
                                      } else {
                                        sliderController.nextPage();
                                      }
                                    },
                                  ),
                                  SizedBox(width: 0.3.sw,),
                                  Expanded(
                                    child: MyButton(
                                      title: "skip".tr,
                                      isOutline: true,
                                      color: Colors.white,
                                      textColor: Colors.white,
                                      onClick: () {
                                        Get.offAllNamed(Routes.MAIN);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                  color: Colors.white
                              ),
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        })
    );
  }

  Widget _introItem({String? image, String? title, String? description,}) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyImage(
            image: image,
            fit: BoxFit.contain,
            width: Get.width * 0.7,
          ),
          30.verticalSpace,
          Text(title ?? "",
            textAlign: TextAlign.center,
            style: MyTextStyle.myBlackBoldLargeTitle,).paddingSymmetric(horizontal: 16),
          8.verticalSpace,
          Text(description ?? "",
            textAlign: TextAlign.center,
            style: MyTextStyle.myGreyTitle,).paddingSymmetric(horizontal: 16),
        ],
      ),
    );
  }
}
