import 'package:flutter/material.dart';

class CustomChoiceChip extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String> onSelected;
  final String selectedValue;

  const CustomChoiceChip({
    Key? key,
    required this.items,
    required this.onSelected,
    required this.selectedValue,
  }) : super(key: key);

  @override
  CustomChoiceChipState createState() => CustomChoiceChipState();
}

class CustomChoiceChipState extends State<CustomChoiceChip> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: widget.items.map((String item) {
        return Container(
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
            child: (ChoiceChip(
              label: Text(item),
              selected: selectedValue == item,
              onSelected: (selected) {
                setState(() {
                  selectedValue = item;
                });
                widget.onSelected(item);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.black),
              ),
            )));
      }).toList(),
    );
  }
}
