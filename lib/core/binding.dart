import 'package:garage/core/controllers/address_controller.dart';
import 'package:garage/core/controllers/cart_controller.dart';
import 'package:garage/core/controllers/checkout_controller.dart';
import 'package:garage/core/controllers/main_controller.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/repositories/categories_repository.dart';
import 'package:get/get.dart';
import 'package:garage/core/repositories/address_repository.dart';
import 'package:garage/core/repositories/auth_repository.dart';
import 'package:garage/core/repositories/cart_repository.dart';
import 'package:garage/core/repositories/checkout_repository.dart';
import 'package:garage/core/repositories/favorite_repository.dart';
import 'package:garage/core/repositories/main_repository.dart';
import 'networking/network_handler.dart';
import 'storage/preference_manager.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.put(PreferenceManager(), permanent: true);
    Get.put(NetworkHandler(), permanent: true);
    Get.put(AuthRepository(), permanent: true);
    Get.put(MainRepository(), permanent: true);
    Get.put(FavoriteRepository(), permanent: true);
    Get.put(MainController(), permanent: true);
    Get.put(UserController(), permanent: true);
    Get.put(CartRepository(), permanent: true);
    Get.put(CartController(), permanent: true);
    Get.lazyPut(() => CheckoutRepository());
    Get.put(CheckoutController(), permanent: true);
    Get.put(AddressRepository(), permanent: true);
    Get.put(AddressController(), permanent: true);
    Get.put(CategoriesRepository(), permanent: true);

  }
}
