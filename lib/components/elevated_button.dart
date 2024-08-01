import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Icon? icon;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          backgroundColor:
              WidgetStateProperty.all(Color.fromRGBO(177, 255, 158, 1)),
          foregroundColor: WidgetStateProperty.all(Colors.black),
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
    );
  }
}
