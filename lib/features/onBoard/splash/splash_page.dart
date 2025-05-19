import 'package:garage/core/ui/my_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:garage/theme/styles.dart';
import 'splash_controller.dart';
import 'splash_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  final SplashController controller = Get.find<SplashController>();
  final SplashState state = Get.find<SplashController>().state;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness:
            GetPlatform.isAndroid ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            GetPlatform.isAndroid ? Brightness.dark : Brightness.light,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward().whenComplete(() => controller.navigate());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: colorPrimary,
        // decoration: const BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage(
        //           "assets/images/splash_bg.png",
        //         ),
        //         fit: BoxFit.cover)),
        child: FadeTransition(
          opacity: _animation,
          child: Align(
            alignment: Alignment.center,
            child: MyImage(
              image: "assets/images/logo.png",
              width: Get.width * 0.5,
              height: Get.width * 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
