import 'package:flutter/material.dart';
import 'basket_page.dart';
import 'estimate_page.dart';
import 'components/basket_counter_icon.dart';
import 'package:provider/provider.dart';
import 'package:paw/state/my_app_state.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = EstimatePage();
      case 1:
        page = EstimatePage();
      case 2:
        page = BasketPage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: page,
      ),
      bottomNavigationBar: Consumer<MyAppState>(
        builder: (context, appState, _) => BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.policy),
              label: 'Insurance',
            ),
            BottomNavigationBarItem(
              icon: BasketIconWithCounter(itemCount: appState.basket.length),
              label: 'Basket',
            ),
          ],
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
        ),
      ),
    );
  }
}
