import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:garage/core/controllers/address_controller.dart';
import 'package:garage/core/networking/models/city.dart';
import 'package:garage/core/ui/LoadingWidget.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/theme/styles.dart';


class AreaSheet extends StatelessWidget {
  final AddressController addressController = Get.find();
  late RxList<StateData?> selectedAreas;
  Function(List<StateData?>?)? onSelected;
  List<StateData?>? preSelected;
  bool? singleSelection;

  AreaSheet({this.singleSelection=false,this.preSelected,this.onSelected}){
    addressController.fetchAreas();
    selectedAreas = <StateData?>[].obs;
    selectedAreas.value = preSelected??[];
  }

  @override
  Widget build(BuildContext context) {
      return Column(
        children: [
          Expanded(
            child: Obx(() => LoadingWidget(
              loadingState: addressController.areas.value,
              onRetryCall: (){addressController.fetchAreas();},
              isEmpty: addressController.areas.value.data?.isEmpty == true,
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: ClampingScrollPhysics(),
                  itemCount: addressController.areas.value.data?.length,
                  itemBuilder: (context,index)=>
                      Theme(
                        data: Theme.of(context).copyWith(colorScheme: ColorScheme.dark(
                            secondary: Theme.of(context).primaryColor),
                            dividerColor: Colors.transparent
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: colorContainer
                          ),
                          margin: EdgeInsets.all(8),
                          child: ExpansionTile(
                            title: Text(addressController.areas.value.data?.elementAt(index).title??"",
                              style: MyTextStyle.myBlackBoldTitle,),
                            // trailing: Obx(()=>
                            //     Opacity(
                            //       opacity: selectedAreas.any((element) => addressController.areas.value.data?.data?.elementAt(index).states?.contains(element)== true) ? 1.0 : 0.5,
                            //       child: InkWell(
                            //         onTap: (){
                            //           if(singleSelection == true){
                            //             return;
                            //           }
                            //
                            //           if(addressController.areas.value.data?.data?.elementAt(index).states?.every((element) => selectedAreas.contains(element)) == true){
                            //             selectedAreas.removeWhere((element) => addressController.areas.value.data?.data?.elementAt(index).states?.contains(element)== true);
                            //           }else{
                            //             selectedAreas.removeWhere((element) => addressController.areas.value.data?.data?.elementAt(index).states?.contains(element)== true);
                            //             selectedAreas.addAll(addressController.areas.value.data?.data?.elementAt(index).states??[]);
                            //           }
                            //         },
                            //         child: Image.asset("assets/images/check.png",
                            //           width: 25,),
                            //       ),
                            //     ),
                            // ),
                            expandedCrossAxisAlignment: CrossAxisAlignment.start,
                            expandedAlignment: Alignment.centerLeft,
                            collapsedIconColor: colorGrey,
                            children: addressController.areas.value.data?.elementAt(index).states?.map((e) =>
                                SizedBox(
                                  width: double.infinity,
                                  child: InkWell(
                                    onTap: (){
                                      if(singleSelection == true){
                                        selectedAreas.add(e);
                                        onSelected?.call(selectedAreas.value);
                                        Navigator.of(context).pop();
                                        return;
                                      }

                                      if(selectedAreas.contains(e))
                                        selectedAreas.remove(e);
                                      else
                                        selectedAreas.add(e);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 50,right: 16),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(e.title??"",
                                              textAlign: TextAlign.start,
                                              style: MyTextStyle.normalStyle,),
                                          ),
                                          // Obx(()=>Visibility(
                                          //   visible: selectedAreas.contains(e),
                                          //     child: Image.asset("assets/images/check.png", width: 25,))
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                )).toList()??[],
                          ),
                        ),
                      )),
            )),
          ),
          Visibility(
            visible: singleSelection == false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: MyButton(
                title: "confirm".tr,
                onClick: (){
                  onSelected?.call(selectedAreas.value);
                  Navigator.of(context).pop();
                },
              ),
            ),
          )
        ],
      );
  }


}
