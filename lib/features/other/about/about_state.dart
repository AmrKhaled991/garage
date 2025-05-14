import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:garage/core/networking/loading_state.dart';

class AboutState {
  var about = Rx<LoadingState>(LoadingState.loading());
  AboutState() {
    ///Initialize variables
  }
}
