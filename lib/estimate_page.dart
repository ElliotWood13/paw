import 'package:flutter/material.dart';
import 'package:paw/components/custom_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:paw/state/my_app_state.dart';
import 'package:paw/components/elevated_button.dart';

class EstimatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.basket.contains(pair)) {
      icon = Icons.shopping_basket;
    } else {
      icon = Icons.shopping_basket_outlined;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Get a Quote in a Meowment..',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          SizedBox(height: 65),
          Stack(children: [
            Form(
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 1)),
                margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('What is the age range of your cat?'),
                    SizedBox(height: 10),
                    CustomDropdownButton(
                      items: ['0-3', '4-7', '8-10', '10+'],
                      onChanged: (value) {
                        print('Selected: $value');
                      },
                    ),
                    SizedBox(height: 30),
                    Text('Has your cat been de-sexed?'),
                    SizedBox(height: 10),
                    CustomDropdownButton(
                      items: ['Yes', 'No'],
                      onChanged: (value) {
                        print('Selected: $value');
                      },
                    ),
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(50, -120), // Move the image upwards by 10 pixels
              child: Image.asset(
                'assets/cat_avatar.png', // Path to your asset
                width: 200.0, // Set the desired width
                height: 200.0, // Set the desired height
              ),
            ),
          ]),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomElevatedButton(
                icon: Icon(icon),
                text: 'Add to basket',
                onPressed: () {
                  appState.toggleBasket();
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
