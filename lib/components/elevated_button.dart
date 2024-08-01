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
                color: disabled == false ? Colors.black : Colors.grey.shade700,
                offset: Offset(2, 2),
                blurRadius: 0,
                spreadRadius: 0,
              ),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(disabled == false
                  ? Color.fromRGBO(177, 255, 158, 1)
                  : Color.fromRGBO(228, 239, 224, 1)),
              foregroundColor: WidgetStateProperty.all(
                  disabled == false ? Colors.black : Colors.grey[700]),
              padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(vertical: 16, horizontal: 32)),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                    color:
                        disabled == false ? Colors.black : Colors.grey.shade700,
                    width: 3),
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
