import 'package:garage/core/networking/base/api_response.dart';
import 'package:garage/core/networking/base/dynamic_model.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/address.dart';
import '../networking/models/city.dart';
import 'base_repository.dart';

class AddressRepository extends BaseRepository {
  Future<LoadingState<List<City>>> getAreas() async {
    return networkHandler.getRequest(
      endpoint: "regions-with-cities",
      create: () => APIListResponse<City>(create: () => City()),
      query: {"type": "city_with_states"},
    );
  }

  Future<LoadingState<List<AddressData>>> getAddresses() async {
    return networkHandler.getRequest(
      endpoint: "address/list",
      create: () => APIListResponse<AddressData>(create: () => AddressData()),
    );
  }

  Future<LoadingState> addAddresses(Map<String, String> data) async {
    return networkHandler.postRequest(
      endpoint: "address/create",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
      body: data,
    );
  }

  Future<LoadingState> deleteAddresses(int id) async {
    return networkHandler.postRequest(
      endpoint: "address/delete/$id",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
    );
  }

  Future<LoadingState> setDefaultAddress(int id) async {
    return networkHandler.postRequest(
      endpoint: "address/make-default/$id",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
    );
  }
}
