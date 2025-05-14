import 'package:get/get.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/repositories/main_repository.dart';
import 'about_state.dart';

class AboutController extends GetxController {
  final AboutState state = AboutState();

  MainRepository mainRepository = Get.find();

  @override
  void onInit() {
    fetchTerms();
    super.onInit();
  }

  void fetchTerms() async{
    state.about.value = LoadingState.loading();
    state.about.value = await mainRepository.getAbout();
  }
}
