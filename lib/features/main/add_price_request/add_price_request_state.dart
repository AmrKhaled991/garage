import 'package:flutter/widgets.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/ui/select_drop_list%20.dart';
import 'package:garage/features/main/add_price_request/model/company_ui_model.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../../core/networking/models/category.dart';

class AddPriceRequestState {
  final categoriesList = LoadingState<List<Category>?>().obs;
  Rx<OptionItem?> categoryItem = Rx<OptionItem?>(null);
  Rx<CompanyUiModel?> companyItem = Rx<CompanyUiModel?>(null); // <OptionItem>
  var description = TextEditingController();
  var quantity = TextEditingController();
  Rx<AssetEntity?> selectedAsset = Rx<AssetEntity?>(null);
  var submitAddPrice = LoadingState().obs;
  AddPriceRequestState();
}
