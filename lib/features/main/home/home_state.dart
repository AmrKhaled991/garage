import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/category.dart';
import 'package:garage/core/networking/models/company.dart';
import 'package:garage/core/networking/models/home_response/record.dart';
import 'package:get/get.dart';

class HomePageState {
  final categoriesList = LoadingState<List<Category>?>().obs;
  final slider = LoadingState<List<Banner>?>().obs;

  HomePageState() {
    ///Initialize variables
  }
}
