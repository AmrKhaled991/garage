import 'package:get/get.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/repositories/main_repository.dart';
import 'terms_state.dart';

class TermsController extends GetxController {
  final TermsState state = TermsState();
  MainRepository mainRepository = Get.find();

  @override
  void onInit() {
    fetchTerms();
    super.onInit();
  }

  void fetchTerms() async {
    state.terms.value = LoadingState.loading();
    state.terms.value = await mainRepository.getTerms();
  }
}
