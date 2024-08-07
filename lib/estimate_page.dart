import 'package:flutter/material.dart';
import 'package:paw/components/custom_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:paw/state/my_app_state.dart';
import 'package:paw/components/elevated_button.dart';

class EstimatePage extends StatefulWidget {
  @override
  EstimatePageState createState() => EstimatePageState();
}

class EstimatePageState extends State<EstimatePage> {
  final _formKey = GlobalKey<FormState>();
  String? ageRange;
  String? deSexed;
  bool isFormComplete = false;

  _validateForm() {
    if (ageRange != null && deSexed != null) {
      setState(() {
        isFormComplete = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var basket = appState.basket;
    var catInsurance =
        BasketItem(product: 'Cat Insurance', value: 85, showInBasket: true);

    IconData icon;
    if (basket.any((element) => element.product == catInsurance.product)) {
      icon = Icons.shopping_basket;
    } else {
      icon = Icons.shopping_basket_outlined;
    }

    return Stack(
      children: [
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
              SizedBox(
                width: 300,
                child: Text(
                  'Get an estimate in a Meowment..',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 65),
              Stack(
                children: [
                  Form(
                    key: _formKey,
                    onChanged: _validateForm(),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(48),
                          border: Border.all(color: Colors.black, width: 1)),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('What is the age of your cat?'),
                          SizedBox(height: 10),
                          CustomDropdownButton(
                            items: ['0-3', '4-7', '8-10', '10+'],
                            onChanged: (value) {
                              setState(() {
                                ageRange = value;
                              });
                            },
                          ),
                          SizedBox(height: 30),
                          Text('Has your cat been de-sexed?'),
                          SizedBox(height: 10),
                          CustomDropdownButton(
                            items: ['Yes', 'No'],
                            onChanged: (value) {
                              setState(() {
                                deSexed = value;
                              });
                            },
                          ),
                          if (isFormComplete)
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 30, 0, 5),
                                  child: Text('We estimate it would cost:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text('\$85.00 per month',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                Theme.of(context).primaryColor,
                                            decorationThickness: 2,
                                          )),
                                ),
                                Text('to insure your cat!',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset:
                        isFormComplete ? Offset(30, -103) : Offset(30, -120),
                    child: Image.asset(
                      isFormComplete
                          ? 'assets/cat_avatar_quote.png'
                          : 'assets/cat_avatar.png',
                      width: 200.0,
                      height: 200.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              CustomElevatedButton(
                icon: Icon(icon),
                text: 'Add to basket',
                disabled: !isFormComplete,
                onPressed: () {
                  appState.toggleBasket(catInsurance);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
