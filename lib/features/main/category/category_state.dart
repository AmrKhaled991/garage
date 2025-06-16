import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/provider_response/provider_response.dart';
import 'package:get/get.dart';

class CategoryState {
  RxnInt selectedCategoryId = RxnInt();
  RxnInt selectedIndex = RxnInt();
  final providersList = LoadingState<List<ProviderResponse>?>().obs;
  CategoryState() {
    ///Initialize variables
  }
}
