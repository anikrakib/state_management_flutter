import 'package:flutter/material.dart';
import 'package:weight_calculator/constants.dart';

class IconContent extends StatelessWidget {
  final String label;
  final IconData icon;

  const IconContent({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kCardMargin * 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: Colors.white,
          ),
          const SizedBox(height: labelIconSpacing),
          Text(
            label.toUpperCase(),
            style: kLabelTextStyle,
          ),
        ],
      ),
    );
  }
}
