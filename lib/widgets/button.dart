import 'package:flutter/material.dart';
import 'package:resident_zombies/theme/global_theme.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Icon icon;
  final bool outline;
  final EdgeInsets padding;

  const Button(
      {Key key,
      this.onPressed,
      this.label,
      this.icon,
      this.outline = false,
      this.padding = const EdgeInsets.all(0.0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8.0),
        gradient: zombieGradient,
        border: Border.all(color: Colors.lightGreen),
      ),
      child: Material(
        color: Colors.transparent,
        textStyle: TextStyle(
          color: outline ? Colors.lightGreen : Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
          letterSpacing: 1.25,
        ),
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: padding,
            child: Builder(
              builder: (context) {
                if (icon == null) {
                  return Center(
                    child: Text(label),
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    icon,
                    Text(label),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
