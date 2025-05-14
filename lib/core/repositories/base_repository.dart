import 'package:get/get.dart';
import 'package:garage/core/networking/network_handler.dart';


class BaseRepository{
  Map<String, dynamic> body = {};

  final NetworkHandler networkHandler = Get.find();

}