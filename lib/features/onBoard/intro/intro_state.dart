import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/IntroSlider.dart';

class IntroState {

  var intros = Rx<LoadingState<List<IntroSlider>?>?>(LoadingState.loading());

  IntroState() {
    ///Initialize variables
  }
}
