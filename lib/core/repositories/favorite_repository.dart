
import 'package:garage/core/networking/models/clinic.dart';
import 'package:garage/core/networking/models/restaurant.dart';
import 'package:garage/core/storage/preference_manager.dart';
import 'package:get/get.dart';
import 'package:garage/core/networking/loading_state.dart';
import '../networking/base/api_response.dart';
import '../networking/base/dynamic_model.dart';
import 'base_repository.dart';


class FavoriteRepository extends BaseRepository{
  PreferenceManager preferenceManager = Get.find();

  Future<LoadingState<List<Clinic>?>> getFavorites({int page = 1}) async{
    return networkHandler.getRequest(
        endpoint: "favs",
        create: ()=> APIListResponse<Clinic>(create: ()=> Clinic()),
            query: {/*"user_id": preferenceManager.getUser?.data?.user?.id.toString(),*/
        "page": page.toString()}
    );
  }

  Future<bool> isFavorite(int id) async{
    var result = await networkHandler.getRequest(
      endpoint: "ads/${id.toString()}/check-favorite",
      create: ()=> APIDynamicResponse(create: ()=> DynamicModel()),
      /*query: {"user_id": preferenceManager.getUser?.data?.user?.id.toString()}*/);
    return result.success;
  }

  Future<bool> deleteFavorite(int id) async{
    var result = await networkHandler.postRequest(
      endpoint: "favourites/delete/${id.toString()}",
      create: ()=> APIDynamicResponse(create: ()=> DynamicModel()),
      /*query: {"user_id": preferenceManager.getUser?.data?.user?.id.toString()}*/);
    return result.success;
  }

  Future<bool> addFavorite(int id) async{
    var result = await networkHandler.postRequest(
      endpoint: "favourites/store",
      create: ()=> APIDynamicResponse(create: ()=> DynamicModel()),
      body: {"product_id": id.toString()});
    return result.success;
  }

  Future<LoadingState> toggleFavorite(String id) async{
    return networkHandler.getRequest(
      endpoint: "toggle-fav/place/${id.toString()}",
      create: ()=> APIDynamicResponse(create: ()=> DynamicModel()),
      /*body: {"user_id": preferenceManager.getUser?.data?.user?.id.toString()}*/);
  }

}