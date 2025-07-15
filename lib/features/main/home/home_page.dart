// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/user_car/user_car.dart';
import 'package:garage/core/ui/LoadingWidget.dart';
import 'package:garage/features/main/home/widgets/custom_category_card.dart';
import 'package:garage/features/main/home/widgets/home_slider.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/routes/arguments.dart';
import 'package:get/get.dart';

import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/features/main/common/add_container.dart';
import 'package:garage/features/main/common/text_header_widget.dart';
import 'package:garage/theme/styles.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'home_logic.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  HomeController controller = Get.find<HomeController>();
  UserController userController = Get.find<UserController>();

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  Widget build(BuildContext context) {
    final state = Get.put(HomeController()).state;

    return MyScaffold(
      body: SmartRefresher(
        header: const WaterDropHeader(),
        controller: _refreshController,
        physics: const BouncingScrollPhysics(),
        onRefresh:
            () => {
              controller.getCategories(forceRefresh: true),
              controller.getHomeData(),
              controller.getUserCars(),

              _refreshController.refreshCompleted(),
            },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.toNamed(Routes.SEARCH),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: MyshapesStyle.PrimaryDecoration,
                        child: const Row(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyImage(image: "assets/images/ic_search.svg"),
                            Text(
                              'البحث عن مركز خدمة',
                              style: TextStyle(
                                color: Color(0xFF9E9B94),
                                fontSize: 16,
                                fontFamily: 'Zain',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(Routes.NotificatoinsPage),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1, color: colorContainer),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: const MyImage(
                        image: "assets/images/ic_notifications.svg",
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  HomeSlider(controller: controller, state: state),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Visibility(
                visible: userController.isLogged.value,
                child: TextHeaderWidget(
                  title: "recently_viewed".tr,
                  child: Obx(() {
                    var carList = state.userCars.value.data;
                    return LoadingWidget(
                      loadingState: state.userCars.value,
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 5),

                        itemCount:
                            (carList == null || carList.isEmpty)
                                ? 1
                                : carList.length + 1,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 2.5,
                            ),

                        itemBuilder: (context, index) {
                          return carList?.length != index
                              ? UserCarWidget(userCar: carList![index])
                              : AddContainer(
                                title: 'أضف سيارة',
                                onTap: () {
                                  if (!userController.isLogged.value) {
                                    Get.toNamed(Routes.LOGIN);
                                    return;
                                  }
                                  Get.toNamed(Routes.SelectTheBrandPageKey);
                                },
                              );
                        },
                      ),
                    );
                  }),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  TextHeaderWidget(
                    title: "categories".tr,
                    child: Obx(() {
                      return LoadingWidget(
                        loadingState: state.categoriesList.value,
                        isEmpty:
                            state.categoriesList.value.data?.isEmpty == true,
                        onRetryCall:
                            () => controller.getCategories(forceRefresh: true),
                        child: SizedBox(
                          width: Get.width,
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                ),
                            itemBuilder: (context, index) {
                              var item =
                                  state.categoriesList.value.data?[index];
                              return CustomCategoryCard(
                                image: item?.image ?? '',
                                text: item?.name ?? '',
                                onTab: () {
                                  Get.toNamed(
                                    Routes.CATEGRYPAGEKEY,
                                    arguments: state.categoriesList.value.data,
                                  );
                                },
                              );
                            },
                            itemCount:
                                state.categoriesList.value.data?.length ?? 0,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserCarWidget extends StatelessWidget {
  final UserCar userCar;
  const UserCarWidget({super.key, required this.userCar});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: MyshapesStyle.PrimaryDecoration,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 19),
      child: Row(
        children: [
          MyImage(
            image: userCar.brand?.image ?? "assets/images/ic_car.svg",
            width: 40,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userCar.brand?.name ?? "سيارتك",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Zain',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                userCar.year ?? "2022",
                style: const TextStyle(
                  color: Color(0xFFCCCAC7),
                  fontSize: 14,
                  fontFamily: 'Zain',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
