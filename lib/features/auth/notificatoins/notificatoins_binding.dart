import 'package:get/get.dart';

import 'notificatoins_logic.dart';

class NotificationsBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => NotificatoinsLogic());
  }
}
