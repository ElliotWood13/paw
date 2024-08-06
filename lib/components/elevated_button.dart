import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool disabled;
  final Icon? icon;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.disabled = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: disabled ? Colors.grey.shade700 : Colors.black,
              offset: Offset(2, 2),
              blurRadius: 0,
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: ElevatedButton(
          onPressed: disabled ? null : onPressed,
          style: Theme.of(context).elevatedButtonTheme.style,
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
      ),
    );
  }
}
