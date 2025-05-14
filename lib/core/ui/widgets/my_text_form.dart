import 'package:flutter/material.dart';
import 'package:garage/theme/styles.dart';

class MyTextForm extends StatefulWidget {
  MyTextForm({
    Key? key,
    this.onChanged,
    this.onSubmitted,
    this.hint,
    this.icon,
    this.isPassword = false,
    this.textInputType,
    this.lines = 1,
    this.controller,
    this.backgroundColor,
    this.hintStyle,
    this.textStyle,
    this.hasIconConstraints = true,
  }) : super(key: key);

  Function(String)? onChanged;
  Function(String)? onSubmitted;
  String? hint;
  Widget? icon;
  bool? isPassword;
  int? lines;
  Color? backgroundColor;
  TextInputType? textInputType;
  TextEditingController? controller;
  TextStyle? hintStyle;
  TextStyle? textStyle;
  bool? hasIconConstraints;

  @override
  State<MyTextForm> createState() => _MyTextFormState();
}

class _MyTextFormState extends State<MyTextForm> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      controller: widget.controller,
      textInputAction:
          widget.onSubmitted != null
              ? TextInputAction.search
              : TextInputAction.done,
      keyboardType:
          widget.isPassword == true
              ? TextInputType.visiblePassword
              : (widget.textInputType ?? TextInputType.text),
      obscureText: widget.isPassword == true ? _obscured : false,
      autocorrect: false,
      focusNode: textFieldFocusNode,
      style: widget.textStyle ?? MyTextStyle.myWhiteSubTitle,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      minLines: widget.lines,
      maxLines: widget.lines,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        labelStyle: widget.hintStyle ?? MyTextStyle.myGreyTitle,
        hintStyle: widget.hintStyle ?? MyTextStyle.myGreyTitle,
        hintText: widget.hint,
        labelText: widget.hint,
        fillColor: widget.backgroundColor ?? colorContainer,
        filled: true,
        isDense: true,

        prefixIcon: widget.icon,
        prefixIconConstraints:
            widget.hasIconConstraints == true
                ? const BoxConstraints(maxWidth: 100, maxHeight: 40)
                : null,
        suffixIcon:
            widget.isPassword == false
                ? null
                : Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                  child: GestureDetector(
                    onTap: _toggleObscured,
                    child: Icon(
                      _obscured
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      size: 24,
                      color: colorDarkGrey,
                    ),
                  ),
                ),
      ),
    );
  }
}
