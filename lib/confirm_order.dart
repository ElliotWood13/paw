import 'package:flutter/material.dart';

class ConfirmOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Stack(children: [
              Positioned(
                top: 16.0,
                left: 16.0,
                child: Image.asset(
                  'assets/logo.png',
                  width: 50.0,
                  height: 50.0,
                ),
              ),
              Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text('Confirm Order Page'),
                    TextButton(
                      child: (Text('Back to checkout')),
                      onPressed: () => {Navigator.pop(context)},
                    ),
                  ]))
            ])));
  }
}
