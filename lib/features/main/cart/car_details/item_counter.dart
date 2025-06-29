// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:garage/core/controllers/cart_controller.dart';

import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ItemCounter extends StatefulWidget {
  int itemId;
  int quantity;

  ItemCounter({Key? key, required this.itemId, required this.quantity})
    : super(key: key);

  @override
  State<ItemCounter> createState() => _ItemCounterState();
}

class _ItemCounterState extends State<ItemCounter> {
  CartController cartController = Get.find();
  int counter = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    counter = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: MyshapesStyle.lightGrayDecoration,
            child: const Icon(Icons.remove, color: Colors.white),
          ),
          onTap: () {
            counter == 1
                ? null
                : {
                  setState(() {
                    counter--;
                  }),
                  cartController.decreaseCartIem(
                    widget.itemId,
                    1,
                    onFinish: (value) {
                      value == false
                          ? setState(() {
                            counter++;
                          })
                          : setState(() {});
                    },
                  ),
                };
          },
        ),
        Text(
          counter.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        InkWell(
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: MyshapesStyle.lightGrayDecoration,
            child: const Icon(Icons.add, color: Colors.white),
          ),
          onTap: () {
            counter == 9
                ? null
                : {
                  setState(() {
                    counter++;
                  }),
                  cartController.addToCart(
                    widget.itemId,
                    1,
                    onFinish: (value) {
                      value == false
                          ? setState(() {
                            counter--;
                          })
                          : null;
                    },
                  ),
                };
          },
        ),
      ],
    );
  }
}
