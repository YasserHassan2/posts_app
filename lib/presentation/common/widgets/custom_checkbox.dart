import 'package:flutter/material.dart';

import '../../../utils/resources/color_manager.dart';
import '../../../utils/resources/font_manager.dart';
import '../../../utils/resources/styles_manager.dart';

class CustomCheckBox extends StatefulWidget {
  bool _checked = false;
  String _fieldName;
  Function(bool) _onChange;

  CustomCheckBox(
      {required bool checked,
      required String fieldName,
      required Function(bool) onChange})
      : _checked = checked,
        _fieldName = fieldName,
        _onChange = onChange;

  @override
  CustomCheckBoxState createState() => CustomCheckBoxState();
}

class CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            fillColor: MaterialStateProperty.all(ColorManager.primary),
            checkColor: ColorManager.white,
            focusColor: ColorManager.primary,
            activeColor: ColorManager.primary,
            hoverColor: ColorManager.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.0),
            ),
            side: MaterialStateBorderSide.resolveWith(
              (states) => BorderSide(width: 1.0, color: Colors.transparent),
            ),
            value: widget._checked,
            onChanged: (newValue) {
              setState(() {
                widget._checked = newValue ?? false;
                widget._onChange(newValue ?? false);
              });
            }),
        Text(
          widget._fieldName,
          style: getRegularStyle(
              color: ColorManager.labelsTextColor, fontSize: 13),
        ),
      ],
    );
  }
}
