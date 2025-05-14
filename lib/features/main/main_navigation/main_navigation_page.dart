import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/features/auth/profile/profile_page.dart';
import 'package:garage/features/main/home/home_page_view.dart';
import 'package:garage/features/main/main_navigation/main_navigation_state.dart';
import 'package:garage/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main_navigation_controller.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  final List<Widget> _children = [
    const HomePagePage(),
    Container(),
    Container(),
    Container(),
    ProfilePage(),
  ];

  final MainNavigationController mainNavigationController = Get.find();
  final MainNavigationState state = Get.find<MainNavigationController>().state;
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      bottomNavigationBar: _buildBottomNavigationBar(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: colorSecondary,
      //   elevation: 0,
      //   shape: StadiumBorder(),
      //   onPressed: () {
      //     if(userController.isLogged.value){
      //       // if(widget.userController.user.value?.data?.user?.type == "user" || widget.userController.user.value?.data?.user?.package !=null) {
      //       Get.toNamed(Routes.SECTION_AREA_IMAGES);
      //       // }else{
      //       //   Get.toNamed(Routes.PACKAGES,arguments: {MyArguments.WITH_ADD_AD_BUTTON: true});
      //       // }
      //     }else{
      //       Get.toNamed(Routes.LOGIN);
      //     }
      //   },
      //   child: Icon(
      //     Icons.add,
      //     size: 30,
      //   ),
      //   // elevation: 5.0,
      // ),
      body: Obx(() {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _children[state.currentIndex.value],
        );
      }),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(() {
      return BottomNavigationBar(
        items: _getNavigationItems(),
        backgroundColor: colorContainer,
        elevation: 0,
        iconSize: 30,
        currentIndex: state.currentIndex.value,
        onTap: (index) {
          state.currentIndex.value = index;
        },
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: const IconThemeData(color: colorPrimary),
        selectedItemColor: colorPrimary,
        unselectedItemColor: colorWhite,
        selectedLabelStyle: MyTextStyle.bottomNavigationStyle,
        unselectedLabelStyle: MyTextStyle.bottomNavigationStyle,
      );
    });
  }

  List<BottomNavigationBarItem> _getNavigationItems() {
    return [
      _navigationItem("home".tr, "assets/images/ic_home.svg"),
      _navigationItem("my_orders".tr, "assets/images/ic_my_orderd.svg"),
      _navigationItem("cart".tr, "assets/images/ic_cart.svg"),
      _navigationItem("messages".tr, "assets/images/ic_message.svg"),
      _navigationItem("my_account".tr, "assets/images/ic_profile.svg"),
    ];
  }

  BottomNavigationBarItem _navigationItem(
    String title,
    String icon, {
    bool colored = false,
  }) {
    return BottomNavigationBarItem(
      label: title,
      activeIcon: MyImage(
        image: icon,
        color: colored ? null : colorPrimary,
        height: 20,
        semanticsLabel: title,
      ).paddingAll(8),
      icon: MyImage(
        image: icon,
        semanticsLabel: title,
        color: colored ? null : colorNavigationUnSelected,
        height: 20,
      ).paddingAll(8),
    );
  }
}
