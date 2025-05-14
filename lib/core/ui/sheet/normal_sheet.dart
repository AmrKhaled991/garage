import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:garage/theme/styles.dart';

class NormalSheet extends StatelessWidget {
  final String? title;
  final Widget? child;

  NormalSheet({Key? key, this.child, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 1,
      minChildSize: 0.9,
      initialChildSize: 1,
      // snap: false,
      expand: true,
      builder: (BuildContext context, ScrollController scrollController) {
        return SafeArea(
          child: Column(
            children: [
              Container(
                height: 60,
                color: colorBG,
                child: Stack(
                  children: [
                    // Positioned.directional(
                    //   textDirection: TextDirection.ltr,
                    //   end: 8,
                    //   top: 8,
                    //   child: GestureDetector(
                    //     onTap: (){
                    //       Get.back();
                    //     },
                    //     child: Container(
                    //       padding: EdgeInsets.all(4),
                    //       decoration: BoxDecoration(
                    //         color: Colors.black.withOpacity(0.1),
                    //         shape: BoxShape.circle,
                    //       ),
                    //       child: Icon(
                    //         Icons.close,
                    //         size: 24,
                    //         color: Colors.black54,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Center(child: Text(title??"", style: MyTextStyle.myBlackBoldTitle,)),
                    Positioned(
                      top: 8,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: ShapeDecoration(
                              shape: StadiumBorder(),
                              color: Colors.grey.shade400,
                            ),
                            height: 5,
                            width: 100,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: child??Container(),
              )
            ],
          ),
        );
      },
    );
  }
}