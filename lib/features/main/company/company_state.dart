import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/provider_details_response/provider_details_response.dart';
import 'package:get/get.dart';

class CompanyState {
  RxnInt id = RxnInt();
  final providerDetails = LoadingState<ProviderDetailsResponse?>().obs;
  CompanyState() {
    ///Initialize variables
  }
}
