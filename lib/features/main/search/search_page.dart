import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide SearchController;

import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/features/main/search/search_controller.dart';
import 'package:garage/features/main/search/widgets/provider_searched_items.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';
class SearchPage extends StatelessWidget {
  SearchController logic = Get.find<SearchController>();

  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      body: NestedScrollView(
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              SliverAppBar(
                iconTheme: const IconThemeData(color: colorWhite),
                surfaceTintColor: colorBlack,
                pinned: true,
                backgroundColor: colorBlack,
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: MyTextForm(
                    hasIconConstraints: false,
                    hint: "what_you_looking_for".tr,
                    icon: const MyImage(
                      image: "assets/images/ic_search.svg",
                      height: 10,
                      width: 10,
                      fit: BoxFit.scaleDown,
                    ),
                    onChanged: (search) => logic.searchChange(search),
                  ),
                ),
              ),
            ],
        body: ProviderSearchedItems(searchState: logic.state),
      ),
    );
  }
}
