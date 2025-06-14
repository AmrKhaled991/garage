import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/category.dart';
import 'package:garage/core/networking/models/company.dart';
import 'package:garage/core/networking/models/home_response/home_response/datum.dart';
import 'package:get/get.dart';

class HomePageState {
  final categoriesList = LoadingState<List<Category>?>().obs;
  final homeData = LoadingState<List<HomeResponse>?>().obs;

  HomePageState() {
    ///Initialize variables
  }
}
