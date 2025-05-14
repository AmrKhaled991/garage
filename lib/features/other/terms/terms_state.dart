import 'package:get/get.dart';
import 'package:garage/core/networking/loading_state.dart';

class TermsState {

  var terms = Rx<LoadingState>(LoadingState.loading());

  TermsState() {
    ///Initialize variables
  }
}
