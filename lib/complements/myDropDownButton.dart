import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropdownButtonExample extends StatefulWidget {
  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

const List<String> list = <String>[
  'Temples',
  'Mosques',
  'Churches',
  'Restraunts',
  'Deserts',
  'Shopping',
  'Beaches'
];

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward_rounded),
      elevation: 16,
      style: const TextStyle(color: Color.fromARGB(255, 11, 8, 17)),
      underline: Container(
        height: 2,
        color: Color.fromARGB(255, 31, 24, 52),
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ));
  }
}
