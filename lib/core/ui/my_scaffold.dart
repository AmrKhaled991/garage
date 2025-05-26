import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/theme/styles.dart';
import 'cart_button.dart';
import 'my_nav_bar.dart';

class MyScaffold extends StatelessWidget {
  String title;
  bool withCart;
  bool withMenu;
  bool withBG;
  bool withBar;
  Widget? trailingWidget;
  Widget? middleWidget;
  Widget? underBarWidget;
  Widget? body;
  Widget? bottomNavigationBar;
  Widget? fab;
  Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;

  // final MainDrawerPageController mainNavigationController = Get.find();

  MyScaffold({
    super.key,
    this.title = "",
    this.middleWidget,
    this.trailingWidget,
    this.underBarWidget,
    this.body,
    this.bottomNavigationBar,
    this.fab,
    this.withCart = false,
    this.withMenu = false,
    this.withBar = true,
    this.withBG = false,
    this.backgroundColor = colorPrimary,
    this.resizeToAvoidBottomInset,
  });

  @override
  Widget build(BuildContext context) {
    // CartController cartController = Get.find();

    Widget? _leading() {
      if (withMenu) {
        return IconButton(
          icon: const Icon(Icons.menu_rounded, color: Colors.white),
          iconSize: 30,
          onPressed: () {
            // mainNavigationController.scaffoldKey.currentState?.isDrawerOpen == true ?
            // mainNavigationController.scaffoldKey.currentState?.closeDrawer()
            //     : mainNavigationController.scaffoldKey.currentState?.openDrawer();
          },
        );
      } else if (ModalRoute.of(context)?.canPop == true)
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      //   CupertinoNavigationBarBackButton(
      //   color: Colors.black,
      //   onPressed: (){
      //     Get.back();
      //   },
      // );
      else
        return null;
    }

    return Scaffold(
      backgroundColor: colorBlack,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,

      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: fab,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        top: true,
        child: Container(
          color: colorBlack,
          child: Column(
            children: [
              if (withBar)
                Container(
                  decoration:
                      (underBarWidget != null)
                          ? const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/bar_bg.png"),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          )
                          : null,
                  // padding: EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      MyCupertinoNavigationBar(
                        // decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //       image: AssetImage("assets/images/bar_bg.png"),
                        //       fit: BoxFit.fill,
                        //     ),
                        //     borderRadius:  BorderRadius.only(bottomLeft: Radius.circular(16),bottomRight: Radius.circular(16),)
                        // ),
                        middle:
                            middleWidget ??
                            Text(
                              title,
                              style: const TextStyle(
                                color: Color(0xFFF7F8F9),
                                fontSize: 20,
                                fontFamily: 'Zain',
                                fontWeight: FontWeight.w700,
                                height: 1.20,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        trailing:
                            !withCart
                                ? trailingWidget
                                : Obx(
                                  () => CartButton(
                                    // itemCount: cartController.cartCount.value!=null? cartController.cartCount.value : 0,
                                  ),
                                ),
                        leading: _leading(),
                        border: const Border.fromBorderSide(BorderSide.none),
                        backgroundColor: colorBlack,

                        padding: const EdgeInsetsDirectional.only(
                          start: 0,
                          end: 0,
                        ),
                        brightness: Brightness.light,
                        automaticallyImplyLeading: false,
                        transitionBetweenRoutes: true,
                        // actionsForegroundColor: Colors.brown,
                      ),
                      if (underBarWidget != null) underBarWidget!,
                    ],
                  ),
                ),
              Expanded(child: body ?? Container()),
            ],
          ),
        ),
      ),
    );
  }
}
