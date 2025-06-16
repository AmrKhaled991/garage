import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/brand/brand.dart';
import 'package:get/get.dart';

class SelectTheBrandState {
  var brands = LoadingState<List<Brand>>().obs;
  var selectedBrandId = Rx<int?>(null);
  var selectedBrandName = Rx<String?>(null);
  SelectTheBrandState() {
    ///Initialize variables
  }
}
