import 'package:flutter/material.dart';
import '../../../constants.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    Key? key,
    required this.onPress,
    required this.label,
  }) : super(key: key);

  final VoidCallback onPress;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: RawMaterialButton(
        onPressed: onPress,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20.0),
          width: double.infinity,
          height: kBottomContainerHeight,
          decoration: const BoxDecoration(
              color: kBottomContainerColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kCardMargin),
                  topRight: Radius.circular(kCardMargin))),
          child: Text(
            label,
            style: kLargeButtonTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
