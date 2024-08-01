import 'package:flutter/material.dart';

class BasketIconWithCounter extends StatelessWidget {
  final int itemCount;

  const BasketIconWithCounter({Key? key, required this.itemCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(Icons.shopping_basket),
        if (itemCount > 0)
          Positioned(
            right: 0,
            child: Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: BoxConstraints(
                minWidth: 12,
                minHeight: 12,
              ),
              child: Text(
                '$itemCount',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
