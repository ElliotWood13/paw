import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/my_app_state.dart';

class BasketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

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
              '${appState.basket.length} in your basket:'),
        ),
        for (var pair in appState.basket)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}
