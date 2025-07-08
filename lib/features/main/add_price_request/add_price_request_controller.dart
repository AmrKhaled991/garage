import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/repositories/main_repository.dart';
import 'package:garage/core/ui/select_drop_list%20.dart';
import 'package:garage/utils/utlis.dart';
import 'package:get/get.dart';
import 'package:photo_manager/src/types/entity.dart';

import 'add_price_request_state.dart';

class AddPriceRequestController extends GetxController {
  final AddPriceRequestState state = AddPriceRequestState();
  final MainRepository _mainRepository = Get.find();

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  bool validations() {
    if (state.categoryItem.value == null) {
      Utils.showSnackBar("category_error".tr);
      return false;
    } else if (state.companyItem.value == null) {
      Utils.showSnackBar("company_error".tr);
      return false;
    } else if (state.description.text.isBlank == true) {
      Utils.showSnackBar("description_error".tr);
      return false;
    } else if (state.quantity.text.isBlank == true) {
      Utils.showSnackBar("error_quantity".tr);
      return false;
    } else if (state.selectedAsset.value == null) {
      Utils.showSnackBar("file_error".tr);
      return false;
    }
    return true;
  }

  getCategories({bool forceRefresh = false}) async {
    if (state.categoriesList.value.data != null && !forceRefresh) {
      return;
    }
    state.categoriesList.value = LoadingState.loading();
    state.categoriesList.value = await _mainRepository.getCategories();
  }

  storePriceRequest({Function(bool)? onFinish}) async {
    Map<String, dynamic> body = {
      "category_id": state.categoryItem.value?.id,
      "provider_id": state.companyItem.value?.id,
      "details": state.description.text,
      "quantity": state.quantity.text,
    };
    final mainImage = state.selectedAsset.value;
    if (mainImage != null) {
      print("mainImage121313123: $mainImage");
      final file = await mainImage.file;
      if (file != null) {
        print("file111111: $file");
        body['files[0]'] = MultipartFile(file, filename: 'file[0].jpg');
        print("file111111: ${body['files[0]']}");
      }
    }

    state.submitAddPrice.value = LoadingState.loading();
    state.submitAddPrice.value = await _mainRepository.storePrice(body: body);
    if (state.submitAddPrice.value.success) {
      onFinish?.call(state.submitAddPrice.value.success);
    } else {
      Utils.showSnackBar(state.submitAddPrice.value.message);
    }
  }

  void setCategoryItem(OptionItem item) {
    if (item.id != null) {
      state.categoryItem.value = item;
    }
  }

  void addAttachment(AssetEntity first) {
    state.selectedAsset.value = first;
  }

  void removeAttachment() {
    state.selectedAsset.value = null;
  }
}
