import 'package:flutter/material.dart';
import 'package:weight_calculator/constants.dart';

class ReUsableCard extends StatelessWidget {
  const ReUsableCard({
    Key? key,
    required this.color,
    this.child,
    this.onTap,
  }) : super(key: key);

  final Color color;
  final Widget? child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: child,
        margin: const EdgeInsets.all(kCardMargin),
        decoration: BoxDecoration(
            color: color,
            borderRadius:
                const BorderRadius.all(Radius.circular(kCardBorderRadius))),
      ),
    );
  }
}
