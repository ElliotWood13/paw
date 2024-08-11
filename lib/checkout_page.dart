import 'package:flutter/material.dart';
import 'package:paw/components/custom_choice_chip.dart';
import 'package:paw/components/custom_dropdown.dart';
import 'package:paw/components/form_container.dart';
import 'package:paw/confirm_order.dart';

class CheckoutPage extends StatefulWidget {
  @override
  CheckoutPageState createState() => CheckoutPageState();
}

class CheckoutPageState extends State<CheckoutPage> {
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();

  String catName = '';
  String catGender = '';
  String catBreed = '';
  DateTime? catAge;
  bool? catDeSexed;
  String ownerName = '';
  DateTime? ownerDob;
  String ownerAddress = '';
  DateTime? startDate;

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(64, 0, 64, 24),
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
                                  _buildCatNameQuestion(),
                                  _buildCatGenderQuestion(),
                                  _buildCatBreedQuestion(),
                                  _buildCatAgeQuestion(),
                                  _buildCatDeSexedQuestion(),
                                  _buildOwnerNameQuestion(),
                                  _buildOwnerDobQuestion(),
                                  _buildOwnerAddressQuestion(),
                                  _buildStartDateQuestion(),
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
                            onPressed: () {
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
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // TODO: Make tertiary button for CustomElevated?
                  TextButton(
                    child: (Text('Back to basket')),
                    onPressed: () => {Navigator.pop(context)},
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
//  TODO: Add full border/shadow around inputs inc date for consistency
  Widget _buildCatNameQuestion() {
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
                initialValue: catName,
                onChanged: (value) {
                  catName = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCatGenderQuestion() {
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
                  selectedValue: catGender,
                  onSelected: (selected) {
                    setState(() {
                      catGender = selected;
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

  Widget _buildCatBreedQuestion() {
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
                setState(() {
                  catBreed = value ?? 'Other';
                  _nextPage();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCatAgeQuestion() {
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
                      setState(() {
                        catAge = pickedDate;
                        _nextPage();
                      });
                    }
                  },
                  readOnly: true,
                  controller: TextEditingController(
                    text: catAge != null ? catAge.toString().split(' ')[0] : '',
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildCatDeSexedQuestion() {
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
                  selectedValue: catDeSexed == null
                      ? ''
                      : catDeSexed == true
                          ? 'Yes'
                          : 'No',
                  onSelected: (selected) {
                    setState(() {
                      catDeSexed = selected == 'Yes' ? true : false;
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

  Widget _buildOwnerNameQuestion() {
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
                initialValue: ownerName,
                onChanged: (value) {
                  ownerName = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOwnerDobQuestion() {
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
                      setState(() {
                        ownerDob = pickedDate;
                        _nextPage();
                      });
                    }
                  },
                  readOnly: true,
                  controller: TextEditingController(
                    text: ownerDob != null
                        ? ownerDob.toString().split(' ')[0]
                        : '',
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildOwnerAddressQuestion() {
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
                initialValue: ownerAddress,
                onChanged: (value) {
                  ownerAddress = value;
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStartDateQuestion() {
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
                      setState(() {
                        startDate = pickedDate;
                        _nextPage();
                      });
                    }
                  },
                  readOnly: true,
                  controller: TextEditingController(
                    text: startDate != null
                        ? startDate.toString().split(' ')[0]
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
