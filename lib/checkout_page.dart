import 'package:flutter/material.dart';
import 'package:paw/components/custom_choice_chip.dart';
import 'package:paw/components/custom_dropdown.dart';
import 'package:paw/components/form_container.dart';
import 'package:paw/confirm_order.dart';
import 'package:paw/state/my_app_state.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  @override
  CheckoutPageState createState() => CheckoutPageState();
}

class CheckoutPageState extends State<CheckoutPage> {
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();
  int _currentPage = 0;
  bool _isPageValid(int pageIndex) {
    var appState = context.read<MyAppState>();
    switch (pageIndex) {
      case 0:
        return appState.catName.isNotEmpty;
      case 1:
        return appState.catGender.isNotEmpty;
      case 2:
        return appState.catBreed.isNotEmpty;
      case 3:
        return appState.catAge != null;
      case 4:
        return appState.catDeSexed != null;
      case 5:
        return appState.ownerName.isNotEmpty;
      case 6:
        return appState.ownerDob != null;
      case 7:
        return appState.ownerAddress.isNotEmpty;
      case 8:
        return appState.startDate != null;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Stack(
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
                  Transform.translate(
                    offset: Offset(15, 2),
                    child: Image.asset(
                      'assets/cat_checkout.png',
                      width: 400.0,
                      height: 100.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(100, 0, 100, 8),
                    child: LinearProgressIndicator(
                      value: (_currentPage + 1) / 9,
                      backgroundColor: Color.fromRGBO(27, 27, 28, 1),
                      color: Color.fromRGBO(253, 165, 255, 1),
                      minHeight: 8,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Just a whisker away from completing your order!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text('Let\'s finalise your insurance quote..'),
                  SizedBox(
                    width: 450,
                    height: 250,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            iconSize: 32,
                            icon: Icon(Icons.arrow_circle_left_outlined),
                            onPressed: _currentPage > 0
                                ? () {
                                    _pageController.previousPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    );
                                  }
                                : null,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 350,
                            child: Form(
                              key: _formKey,
                              child: PageView(
                                controller: _pageController,
                                physics: NeverScrollableScrollPhysics(),
                                onPageChanged: (int page) {
                                  setState(() {
                                    _currentPage = page;
                                  });
                                },
                                children: [
                                  _buildCatNameQuestion(appState),
                                  _buildCatGenderQuestion(appState),
                                  _buildCatBreedQuestion(appState),
                                  _buildCatAgeQuestion(appState),
                                  _buildCatDeSexedQuestion(appState),
                                  _buildOwnerNameQuestion(appState),
                                  _buildOwnerDobQuestion(appState),
                                  _buildOwnerAddressQuestion(appState),
                                  _buildStartDateQuestion(appState),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            iconSize: 32,
                            icon: Icon(Icons.arrow_circle_right_outlined),
                            onPressed: _isPageValid(_currentPage)
                                ? () {
                                    if (_currentPage < 8) {
                                      _pageController.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ConfirmOrder(),
                                        ),
                                      );
                                    }
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // TODO: Make tertiary button for CustomElevated?
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back),
                        SizedBox(width: 8),
                        Text('Back to basket'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TODO: Create resuable components which are shared between these widgets
  Widget _buildCatNameQuestion(MyAppState appState) {
    return FormContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'What is your cat\'s name?',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter pets name',
                ),
                textAlign: TextAlign.center,
                initialValue: appState.catName,
                onChanged: (value) {
                  appState.setCatName(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCatGenderQuestion(MyAppState appState) {
    return FormContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Is your cat a boy or a girl?',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomChoiceChip(
                  items: ['Boy', 'Girl'],
                  selectedValue: appState.catGender,
                  onSelected: (selected) {
                    setState(() {
                      appState.setCatGender(selected);
                      _nextPage();
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCatBreedQuestion(MyAppState appState) {
    return FormContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'What breed is your cat?',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            CustomDropdownButton(
              items: ['Siamese', 'Persian', 'Maine Coon', 'Other'],
              onChanged: (value) {
                appState.setCatBreed(value ?? 'Other');
                _nextPage();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCatAgeQuestion(MyAppState appState) {
    return FormContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'What age is your cat?',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                      _nextPage();
                    }
                  },
                  readOnly: true,
                  controller: TextEditingController(
                    text: appState.catAge != null
                        ? appState.catAge.toString().split(' ')[0]
                        : '',
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildCatDeSexedQuestion(MyAppState appState) {
    return FormContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                    appState.setCatDeSexed(selected == 'Yes' ? true : false);
                    _nextPage();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOwnerNameQuestion(MyAppState appState) {
    return FormContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'What is your human\'s name?',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                  hintText: 'Enter your name',
                ),
                initialValue: appState.ownerName,
                onChanged: (value) {
                  appState.setOwnerName(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOwnerDobQuestion(MyAppState appState) {
    return FormContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'What is your owner\'s date of birth?',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                      appState.setOwnerDob(pickedDate);
                      _nextPage();
                    }
                  },
                  readOnly: true,
                  controller: TextEditingController(
                    text: appState.ownerDob != null
                        ? appState.ownerDob.toString().split(' ')[0]
                        : '',
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildOwnerAddressQuestion(MyAppState appState) {
    return FormContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'What is your owner\'s address?',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                  hintText: 'Enter address',
                ),
                initialValue: appState.ownerAddress,
                onChanged: (value) {
                  appState.setOwnerAddress(value);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStartDateQuestion(MyAppState appState) {
    return FormContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Planned start date for insurance?',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                      appState.setStartDate(pickedDate);
                      _nextPage();
                    }
                  },
                  readOnly: true,
                  controller: TextEditingController(
                    text: appState.startDate != null
                        ? appState.startDate.toString().split(' ')[0]
                        : '',
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _nextPage() {
    if (_currentPage < 8) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }
}
