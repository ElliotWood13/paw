import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:paw/state/my_app_state.dart';
import 'package:paw/components/elevated_button.dart';
import 'package:paw/components/checkbox.dart';
import 'package:paw/helpers/currency_formatter.dart';

class BasketPage extends StatefulWidget {
  @override
  BasketPageState createState() => BasketPageState();
}

class BasketPageState extends State<BasketPage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var basketLength = appState.basket.length;
    var orderTotal = appState.totalValue;

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
          child: basketLength == 0
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/cat_avatar_basket.png',
                      width: 250.0,
                      height: 70.0,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Your Basket..',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text('No mice or items in your basket yet.'),
                  ],
                )
              : Column(
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
                        child: Text(
                          'Your Basket..',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        'You have $basketLength item${basketLength > 1 ? 's' : ''} in your basket.',
                      ),
                    ),
                    ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 350,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: basketLength,
                          itemBuilder: (context, index) {
                            var item = appState.basket[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom: index == basketLength - 1 ? 0 : 10),
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Product:',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              'Amount:',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.product,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              currencyFormatter
                                                  .format(item.value),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )),
                    SizedBox(height: 10),
                    Text(
                      'Insurance quotes are finalised within checkout',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(height: 20),
                    CustomCheckbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                        final catCollar =
                            BasketItem(product: 'Premium Cat Collar', value: 5);
                        appState.toggleBasket(catCollar);
                      },
                      label: 'Add a premium cat collar? Only \$5.00',
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Total: ${currencyFormatter.format(orderTotal)}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 50),
                    CustomElevatedButton(
                      text: 'Continue to checkout',
                      onPressed: () => null,
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
