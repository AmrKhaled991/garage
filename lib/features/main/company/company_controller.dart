import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/repositories/categories_repository.dart';
import 'package:get/get.dart';

import 'company_state.dart';

class CompanyController extends GetxController {
  final CompanyState state = CompanyState();
  final CategoriesRepository categoriesRepository = CategoriesRepository();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    state.id.value = Get.arguments;
    getProviderDetails();
  }

  void getProviderDetails() async {
    state.providerDetails.value = LoadingState.loading();
    state.providerDetails.value = await categoriesRepository.getProviderDetails(
      providerId: state.id.toString(),
    );
  }
}
