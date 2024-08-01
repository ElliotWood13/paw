import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final VoidCallback? onReleased;
  final bool disabled;
  final Icon? icon;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.disabled = false,
    this.icon,
    this.onReleased,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (_) => onPressed(),
        onTapUp: (_) {
          if (onReleased != null) {
            onReleased!();
          }
        },
        onTapCancel: () {
          if (onReleased != null) {
            onReleased!();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(2, 3),
                blurRadius: 0,
                spreadRadius: 1,
              ),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: disabled == false
                  ? WidgetStateProperty.all(Color.fromRGBO(177, 255, 158, 1))
                  : WidgetStateProperty.all(Color.fromRGBO(217, 247, 205, 1)),
              foregroundColor: disabled == false
                  ? WidgetStateProperty.all(Colors.black)
                  : WidgetStateProperty.all(Colors.grey[700]),
              padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(vertical: 16, horizontal: 32)),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.black),
              )),
              elevation: WidgetStateProperty.all(0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  icon!,
                  SizedBox(width: 8),
                ],
                Text(text),
              ],
            ),
          ),
        ));
  }
}
