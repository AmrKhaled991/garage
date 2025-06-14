import 'package:flutter/material.dart';
import 'package:garage/features/main/cart/cart_Page.dart';
import 'package:garage/theme/styles.dart';

class ItemCounter extends StatefulWidget {
  Function(int) counter;
  ItemCounter({Key? key, required this.counter}) : super(key: key);

  @override
  State<ItemCounter> createState() => _ItemCounterState();
}

class _ItemCounterState extends State<ItemCounter> {
  int counter = 1;
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
                : setState(() {
                  counter--;
                  widget.counter(counter);
                });
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
                : setState(() {
                  counter++;
                  widget.counter(counter);
                });
          },
        ),
      ],
    );
  }
}
