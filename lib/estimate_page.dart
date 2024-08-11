import 'package:flutter/material.dart';
import 'package:paw/components/custom_choice_chip.dart';
import 'package:provider/provider.dart';
import 'package:paw/state/my_app_state.dart';
import 'package:paw/components/elevated_button.dart';

class EstimatePage extends StatefulWidget {
  @override
  EstimatePageState createState() => EstimatePageState();
}

class EstimatePageState extends State<EstimatePage> {
  final _formKey = GlobalKey<FormState>();
  bool isFormComplete = false;

  _validateForm() {
    var appState = context.read<MyAppState>();
    setState(() {
      isFormComplete = appState.catAge != null && appState.catDeSexed != null;
    });
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
                      width: 275,
                      padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(48),
                          border: Border.all(color: Colors.black, width: 1)),
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Text('What is the age of your cat?'),
                          SizedBox(height: 10),
                          Container(
                              width: 175,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(2, 3),
                                    blurRadius: 0,
                                    spreadRadius: 1,
                                  ),
                                ],
                                border: Border.all(color: Colors.black),
                              ),
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Select date',
                                ),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                                    appState.setCatAge(pickedDate);
                                  }
                                },
                                readOnly: true,
                                controller: TextEditingController(
                                  text: appState.catAge != null
                                      ? appState.catAge.toString().split(' ')[0]
                                      : '',
                                ),
                              )),
                          SizedBox(height: 30),
                          Text(
                            'Has your cat been de-sexed?',
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomChoiceChip(
                                items: ['Yes', 'No'],
                                selectedValue: appState.catDeSexed == null
                                    ? ''
                                    : appState.catDeSexed == true
                                        ? 'Yes'
                                        : 'No',
                                onSelected: (selected) {
                                  appState.setCatDeSexed(
                                      selected == 'Yes' ? true : false);
                                },
                              ),
                            ],
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
                        isFormComplete ? Offset(45, -103) : Offset(37, -120),
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
