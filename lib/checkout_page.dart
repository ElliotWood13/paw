import 'package:flutter/material.dart';
import 'package:paw/components/elevated_button.dart';
import 'package:paw/components/form_container.dart';

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
                            onPressed: _currentPage < 8
                                ? () {
                                    _pageController.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    );
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 24,
              left: 125,
              right: 125,
              child: CustomElevatedButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => {Navigator.pop(context)},
                text: 'Back to basket',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCatNameQuestion() {
    return FormContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('What is your cat\'s name?'),
            TextFormField(
              onChanged: (value) {
                catName = value;
              },
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
            Text('Is your cat a boy or a girl?'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text('Boy'),
                  selected: catGender == 'Boy',
                  onSelected: (selected) {
                    setState(() {
                      catGender = 'Boy';
                      _nextPage();
                    });
                  },
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text('Girl'),
                  selected: catGender == 'Girl',
                  onSelected: (selected) {
                    setState(() {
                      catGender = 'Girl';
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
            Text('What breed is your cat?'),
            DropdownButton<String>(
              value: catBreed.isNotEmpty ? catBreed : null,
              items: <String>['Siamese', 'Persian', 'Maine Coon', 'Other']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  catBreed = newValue!;
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
            Text('What age is your cat?'),
            TextFormField(
              decoration: InputDecoration(
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
            ),
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
            Text('Has your cat been de-sexed?'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text('Yes'),
                  selected: catDeSexed == true,
                  onSelected: (selected) {
                    setState(() {
                      catDeSexed = true;
                      _nextPage();
                    });
                  },
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text('No'),
                  selected: catDeSexed == false,
                  onSelected: (selected) {
                    setState(() {
                      catDeSexed = false;
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
            Text('What is your human\'s name?'),
            TextFormField(
              onChanged: (value) {
                ownerName = value;
              },
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
            Text('What is your owner\'s date of birth?'),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Select date',
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
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
                text: ownerDob != null ? ownerDob.toString().split(' ')[0] : '',
              ),
            ),
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
            Text('What is your owner\'s address?'),
            TextFormField(
              onChanged: (value) {
                ownerAddress = value;
              },
            ),
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
            Text('Planned start date'),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Select date',
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
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
                text:
                    startDate != null ? startDate.toString().split(' ')[0] : '',
              ),
            ),
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
