import 'package:flutter/material.dart';

import 'button.dart';

class BottomSheetButton extends StatelessWidget {
  static const bottomSheetHeight = 84.0;

  final VoidCallback onPressed;
  final String label;
  final List<BoxShadow> boxShadow;

  const BottomSheetButton({
    Key key,
    this.onPressed,
    this.label,
    this.boxShadow = const [
      BoxShadow(color: Colors.black12, offset: Offset(0, -4), blurRadius: 8)
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: bottomSheetHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: boxShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Button(onPressed: onPressed, label: label),
      ),
    );
  }
}
