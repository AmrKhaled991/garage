import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropListModel {
  DropListModel(this.options);
  final List<OptionItem> options;
}

class OptionItem {
  final String? id;
  final String? title;
  OptionItem({required this.id, required this.title});
}

class SelectDropList extends StatefulWidget {
  final OptionItem selectedItem;
  final DropListModel dropListModel;
  final Function(OptionItem) onOptionSelected;

  // Customization Parameters
  final TextStyle? selectedTextStyle;
  final TextStyle? itemTextStyle;
  final Color? iconColor;
  final BoxDecoration? boxDecoration;
  final BoxDecoration? dropDownDecoration;
  final Icon? leadingIcon;

  const SelectDropList({
    Key? key,
    required this.selectedItem,
    required this.dropListModel,
    required this.onOptionSelected,
    this.selectedTextStyle,
    this.itemTextStyle,
    this.iconColor,
    this.boxDecoration,
    this.dropDownDecoration,
    this.leadingIcon,
  }) : super(key: key);

  @override
  _SelectDropListState createState() => _SelectDropListState();
}

class _SelectDropListState extends State<SelectDropList>
    with SingleTickerProviderStateMixin {
  late OptionItem currentSelectedItem;
  late AnimationController _expandController;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    currentSelectedItem = widget.selectedItem;
    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _toggleDropDown() {
    setState(() {
      _isExpanded = !_isExpanded;
      _isExpanded ? _expandController.forward() : _expandController.reverse();
    });
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggleDropDown,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
            decoration:
                widget.boxDecoration ??
                BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black26,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
            child: Row(
              children: [
                if (widget.leadingIcon != null) ...[
                  widget.leadingIcon!,

                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Text(
                    currentSelectedItem.title ?? "select_category".tr,
                    style:
                        widget.selectedTextStyle ??
                        const TextStyle(
                          color: Color(0xFF307DF1),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up_outlined
                      : Icons.keyboard_arrow_down_rounded,
                  color: widget.iconColor ?? const Color(0xFF307DF1),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: _animation,
          child: Container(
            width: double.infinity,
            decoration:
                widget.dropDownDecoration ??
                const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      color: Colors.black26,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children:
                  widget.dropListModel.options
                      .map((item) => _buildMenuItem(item))
                      .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(OptionItem item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentSelectedItem = item;
          _isExpanded = false;
          _expandController.reverse();
        });
        widget.onOptionSelected(item);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey[300]!)),
        ),
        child: Text(
          item.title ?? "select_category".tr,
          style:
              widget.itemTextStyle ??
              const TextStyle(color: Color(0xFF307DF1), fontSize: 14),
        ),
      ),
    );
  }
}
