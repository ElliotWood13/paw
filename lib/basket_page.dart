import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/my_app_state.dart';

class BasketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var basketLength = appState.basket.length;

    if (appState.basket.isEmpty) {
      return Center(
        child: Text('Meow. No items in your basket yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '$basketLength item${basketLength > 1 ? 's' : ''} in your basket:'),
        ),
        for (var item in appState.basket)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(item),
          ),
      ],
    );
  }
}
