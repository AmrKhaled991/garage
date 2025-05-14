import 'package:garage/core/networking/models/page.dart';
import 'package:garage/theme/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import 'my_scaffold.dart';

class PagesPage extends StatelessWidget {

  PagesData? pagesData;

  PagesPage({this.pagesData}){
    pagesData = Get.arguments != null ? Get.arguments["page"] as PagesData? : pagesData;
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: pagesData?.title??"",
        // drawerController: drawerController,
        // withMenu: true,
        // withCart: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Html(data: pagesData?.description??"",
            style: MyTextStyle.htmlSubTitle(color: Colors.white)),
      )
    );
  }
}
