import 'package:flutter/material.dart';

import '../../../utils/resources/color_manager.dart';
import '../../../utils/resources/font_manager.dart';
import '../../../utils/resources/values_manager.dart';

class CustomDropDown extends StatefulWidget {
  final String? title;
  final List<String>? stringsArr;
  final Function(String?)? onChanged;
  final String? hintText;
  final isValid;
  final paymentMethodError;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? hintTextColor;
  final bool? isTitleBold;

  CustomDropDown(
      {this.title,
      this.stringsArr,
      this.onChanged,
      this.hintText,
      this.isValid,
      this.backgroundColor,
      this.paymentMethodError,
      this.textColor,
      this.borderColor,
      this.hintTextColor,
      this.isTitleBold = true});

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? _intialValue;
  bool _isInit = true;

  @override
  void initState() {
    if (_isInit) {
      _isInit = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        widget.title != null && widget.title != ''
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: AppSize.s12),
                child: Text(
                  widget.title ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: ColorManager.labelsTextColor),
                ),
              )
            : Container(),
        Container(
          height: 45,
          margin: EdgeInsets.symmetric(
              horizontal: AppSize.s12, vertical: AppSize.s4),
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? ColorManager.inputFieldBGColor,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: widget.isValid
                ? Border.all(color: widget.borderColor ?? Colors.transparent)
                : Border.all(color: Colors.red),
          ),
          child: Theme(
            data: ThemeData(canvasColor: Colors.white),
            child: DropdownButtonHideUnderline(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: DropdownButton<String>(
                  value: _intialValue,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Theme.of(context).primaryColor,
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff102993),
                  ),
                  hint: widget.hintText != null
                      ? Text(
                          widget.hintText!,
                          style: TextStyle(
                              color: widget.hintTextColor != null
                                  ? widget.hintTextColor
                                  : Theme.of(context).primaryColor),
                        )
                      : Text(''),
                  onChanged: (String? selectedValue) {
                    setState(() {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      widget.onChanged!(selectedValue);
                      _intialValue = selectedValue;
                    });
                  },
                  items: widget.stringsArr!.map((String date) {
                    return DropdownMenuItem<String>(
                      value: date,
                      child: Text(
                        date,
                        style: TextStyle(
                          color: widget.textColor != null
                              ? widget.textColor
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
        !widget.isValid
            ? Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.paymentMethodError != null
                      ? widget.paymentMethodError
                      : '',
                  style: TextStyle(color: Colors.red),
                ),
              )
            : Container()
      ],
    );
  }
}
