import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/category.dart';
import 'package:garage/core/networking/models/company.dart';
import 'package:get/get.dart';

class HomePageState {
  final categoriesList = LoadingState<List<Category>?>().obs;
  HomePageState() {
    ///Initialize variables
  }
}
