import 'package:flutter/material.dart';
import '../../../constants.dart';

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final int value;
  const RoundIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon),
      onPressed: onPressed,
      constraints: kRoundIconButtonConstraints,
      shape: const CircleBorder(),
      fillColor: kRoundIconButtonColor,
    );
  }
}
