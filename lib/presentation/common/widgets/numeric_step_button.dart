import 'package:flutter/material.dart';

import '../../../utils/resources/color_manager.dart';
import '../../../utils/resources/values_manager.dart';

class NumericStepButton extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final String title;

  final ValueChanged<int> onChanged;

  NumericStepButton(
      {required this.title,
      this.minValue = 0,
      this.maxValue = 10,
      required this.onChanged});

  @override
  State<NumericStepButton> createState() => _NumericStepButtonState();
}

class _NumericStepButtonState extends State<NumericStepButton> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: AppSize.s12),
          child: Text(widget.title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: ColorManager.labelsTextColor)),
        ),
        Container(
          decoration: BoxDecoration(
              color: ColorManager.inputFieldBGColor,
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(AppSize.s16)),
          margin: const EdgeInsets.symmetric(
              horizontal: AppSize.s12, vertical: AppSize.s4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RawMaterialButton(
                onPressed: () {
                  setState(() {
                    if (counter > widget.minValue) {
                      counter -= 50;
                    }
                    widget.onChanged(counter);
                  });
                },
                elevation: 2.0,
                fillColor: ColorManager.white,
                child: Icon(
                  Icons.remove,
                  color: ColorManager.primary,
                ),
                shape: CircleBorder(),
              ),
              Text(
                'SAR $counter',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              RawMaterialButton(
                onPressed: () {
                  setState(() {
                    if (counter < widget.maxValue) {
                      counter += 50;
                    }
                    widget.onChanged(counter);
                  });
                },
                elevation: 2.0,
                fillColor: ColorManager.white,
                child: Icon(
                  Icons.add,
                  color: ColorManager.primary,
                ),
                shape: CircleBorder(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
