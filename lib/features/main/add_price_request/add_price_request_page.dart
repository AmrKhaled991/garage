import 'package:flutter/material.dart';
import 'package:garage/core/networking/models/provider_response/provider_response.dart';
import 'package:garage/core/ui/my_error_widget.dart';
import 'package:garage/core/ui/my_loading_widget.dart';
import 'package:garage/core/ui/sheet/normal_sheet.dart';
import 'package:garage/features/main/add_price_request/add_price_request_widgets/add_attachment.dart';
import 'package:garage/features/main/add_price_request/model/company_ui_model.dart';
import 'package:garage/features/main/category/category_controller.dart';
import 'package:garage/features/main/category/category_state.dart';
import 'package:garage/features/main/price_request/price_request_controller.dart';
import 'package:garage/utils/utlis.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:garage/core/ui/MyLoadingButton.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/theme/styles.dart';

import 'add_price_request_controller.dart';

class AddPriceRequestPage extends StatelessWidget {
  final controller = Get.find<AddPriceRequestController>();
  final state = Get.find<AddPriceRequestController>().state;
  CategoryController categoryController = Get.put(CategoryController());

  AddPriceRequestPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "add_price_request".tr,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          spacing: 8,
          children: [
            WorkCategoriesDropDown(
              controller: controller,
              state: controller.state,
              onOptionSelected: (item) {
                categoryController.categoryChange(null, item.id);
              },
            ),

            Obx(() {
              return state.categoryItem.value != null
                  ? GestureDetector(
                    onTap:
                        () => Utils.showSheet(
                          context,
                          isScrollable: true,
                          NormalSheet(
                            title: "select_company".tr,

                            child: CompaniesSheet(
                              singleSelection: true,
                              selectedCategoryId:
                                  controller.state.companyItem.value?.id ?? 0,

                              onSelected: (states) {
                                state.companyItem.value = states;
                              },
                            ),
                          ),
                        ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 5,
                      ),
                      margin: const EdgeInsets.all(8),
                      decoration: MyshapesStyle.PrimaryDecoration,
                      child: Column(
                        children: [
                          Text(
                            "select_company".tr,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Color(0xFF9E9B94),
                              fontSize: 14,
                              fontFamily: 'Zain',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                            ),
                          ),
                          Obx(() {
                            return Text(
                              state.companyItem.value?.name == null
                                  ? "select_company".tr
                                  : state.companyItem.value!.name ?? '',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Color(0xFFF7F8F9),
                                fontSize: 18,
                                fontFamily: 'Zain',
                                fontWeight: FontWeight.w400,
                                height: 1.20,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  )
                  : const SizedBox.shrink();
            }),
            MyTextForm(
              controller: state.description,
              hint: "order_details".tr,
              textInputType: TextInputType.text,
              lines: 5,
            ),
            MyTextForm(
              controller: state.quantity,
              hint: "quantity".tr,
              textInputType: TextInputType.number,
            ),
            AddAttachment(controller: controller, state: controller.state),
          ],
        ),
      ),
      fab: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        color: colorBlack,
        child: MyLoadingButton(
          title: "add".tr,
          onClick: (p0) {
            if (!controller.validations()) {
              p0.error();
              Future.delayed(const Duration(seconds: 1), () {
                p0.reset();
              });
            }
            controller.storePriceRequest(
              onFinish: (status) {
                if (status) {
                  p0.success();
                  Get.find<PriceRequestController>().state.pagingController
                      .refresh();
                  controller.restForm();
                } else {
                  p0.error();
                }
                Future.delayed(const Duration(seconds: 1), () {
                  p0.reset();
                });
              },
            );
          },
        ),
      ),
    );
  }
}

class CompaniesSheet extends StatefulWidget {
  Function(CompanyUiModel?)? onSelected;
  bool? singleSelection;
  int? selectedCategoryId;
  CompaniesSheet({
    super.key,
    this.singleSelection = false,
    this.onSelected,
    this.selectedCategoryId,
  });

  @override
  State<CompaniesSheet> createState() => _CompaniesSheetState();
}

class _CompaniesSheetState extends State<CompaniesSheet> {
  CategoryState state = Get.put(CategoryController()).state;

  @override
  Widget build(BuildContext context) {
    print("element123123: ${state.selectedCategoryId.value}");

    return PagedListView<int, ProviderResponse>(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      pagingController: state.pagingController,
      padding: const EdgeInsets.all(8),
      builderDelegate: PagedChildBuilderDelegate<ProviderResponse>(
        itemBuilder:
            (context, item, index) =>
                item.data == null
                    ? const SizedBox.shrink()
                    : SizedBox(
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                          widget.onSelected?.call(
                            CompanyUiModel(id: item.id, name: item.name),
                          );
                          Get.back();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.only(
                            top: 12,
                            bottom: 12,
                            left: 50,
                            right: 16,
                          ),
                          decoration: MyshapesStyle.PrimaryDecoration,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.name ?? "",
                                  textAlign: TextAlign.center,
                                  style: MyTextStyle.normalStyle,
                                ),
                              ),
                              // Obx(()=>Visibility(
                              //   visible: selectedAreas.contains(e),
                              //     child: Image.asset("assets/images/check.png", width: 25,))
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
        firstPageProgressIndicatorBuilder: (_) => const MyLoadingWidget(),
        newPageProgressIndicatorBuilder: (_) => const MyLoadingWidget(),
        noItemsFoundIndicatorBuilder:
            (_) => MyErrorWidget(
              onRetryCall: () {
                state.pagingController.refresh();
              },
              errorMsg: "no_data_found".tr,
              errorType: ErrorType.EMPTY,
            ),
        firstPageErrorIndicatorBuilder:
            (_) => MyErrorWidget(
              onRetryCall: () {
                state.pagingController.refresh();
              },
              errorMsg: state.pagingController.error.toString().substring(
                state.pagingController.error.toString().lastIndexOf("(") + 2,
                state.pagingController.error.toString().length - 2,
              ),
              withLogin: true,
            ),
      ),
    );
  }
}
