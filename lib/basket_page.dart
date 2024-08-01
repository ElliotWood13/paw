import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:paw/state/my_app_state.dart';
import 'package:paw/components/elevated_button.dart';
import 'package:paw/components/checkbox.dart';

class BasketPage extends StatefulWidget {
  @override
  BasketPageState createState() => BasketPageState();
}

class BasketPageState extends State<BasketPage> {
  int orderTotal = 85;
  bool isChecked = false;

  void toggleExtras(bool? value, int amount) {
    print('$value, $amount');
    if (value == null) return;

    setState(() {
      isChecked = value;
      if (isChecked) {
        setState(() {
          orderTotal += amount;
        });
      } else {
        setState(() {
          orderTotal -= amount;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var basketLength = appState.basket.length;

    if (appState.basket.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/cat_avatar_basket.png',
              width: 250.0,
              height: 70.0,
            ),
            SizedBox(
                height: 16), // Add some spacing between the image and the text
            Text('No mice or items in your basket yet.'),
          ],
        ),
      );
    }

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/cat_avatar_basket.png',
          width: 250.0,
          height: 70.0,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: SizedBox(
            width: 250,
            child: Text('Your Basket..',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text('You have '
              '$basketLength item${basketLength > 1 ? 's' : ''} in your basket.'),
        ),
        for (var item in appState.basket)
          Container(
            padding: EdgeInsets.all(16),
            constraints: BoxConstraints(maxWidth: 350),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product:',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Amount:',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cat Insurance',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: 8),
                        Text(
                          '\$$item.00',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        SizedBox(height: 10),
        Text(
          'Insurance quotes are finalised within checkout',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        SizedBox(height: 20),
        CustomCheckbox(
            value: isChecked,
            onChanged: (bool? value) => toggleExtras(value, 5),
            label: 'Add a premium cat collar? Only \$5.00'),
        SizedBox(height: 20),
        Text('Total: \$$orderTotal.00',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold)),
        SizedBox(height: 50),
        CustomElevatedButton(
            text: 'Continue to checkout', onPressed: () => null)
      ],
    ));
  }
}
