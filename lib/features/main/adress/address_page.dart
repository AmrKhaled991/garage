import 'package:flutter/material.dart';
import 'package:garage/core/networking/models/adress/user_address.dart';
import 'package:garage/core/ui/my_error_widget.dart';
import 'package:garage/core/ui/my_loading_widget.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/features/main/adress/address_controller.dart';
import 'package:garage/features/main/adress/widgets/address_item.dart';
import 'package:garage/features/main/common/empty_widget.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final RefreshController _refreshController = RefreshController();
  final UserAddressController controller = Get.put(UserAddressController());

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "address".tr,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SmartRefresher(
          controller: _refreshController,
          physics: const BouncingScrollPhysics(),
          header: const WaterDropHeader(),
          onRefresh: () {
            controller.state.pagingController.refresh();
            _refreshController.refreshCompleted();
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: colorWhite, strokeAlign: 1),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 8,
                    ),
                  ),
                  onPressed: () => Get.toNamed(Routes.AddNewAddressPage),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 8,
                    children: [
                      const Icon(Icons.add, size: 25, color: Colors.white),
                      Text(
                        "add_new_address".tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Zain',
                          fontWeight: FontWeight.w700,
                          height: 1.50,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              SliverToBoxAdapter(
                child: PagedListView<int, UserAddress>(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  pagingController: controller.state.pagingController,
                  padding: const EdgeInsets.all(8),
                  builderDelegate: PagedChildBuilderDelegate<UserAddress>(
                    itemBuilder:
                        (context, item, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: AddressItem(item: item),
                        ),
                    firstPageProgressIndicatorBuilder:
                        (_) => const MyLoadingWidget(),
                    newPageProgressIndicatorBuilder:
                        (_) => const MyLoadingWidget(),
                    noItemsFoundIndicatorBuilder:
                        (_) => EmptyWidget(title: "no_data_found".tr),
                    firstPageErrorIndicatorBuilder:
                        (_) => MyErrorWidget(
                          onRetryCall: () {
                            controller.state.pagingController.refresh();
                          },
                          errorMsg: controller.state.pagingController.error
                              .toString()
                              .substring(
                                controller.state.pagingController.error
                                        .toString()
                                        .lastIndexOf("(") +
                                    2,
                                controller.state.pagingController.error
                                        .toString()
                                        .length -
                                    2,
                              ),
                          withLogin: true,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
