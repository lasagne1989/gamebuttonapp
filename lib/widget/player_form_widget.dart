import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class PlayerFormWidget extends StatelessWidget {
  final String name;
  final DateTime dob;
  final ValueChanged<String> onChangedName;
  final ValueChanged<DateTime> onChangedDob;
  final VoidCallback onSavedPlayer;

  const PlayerFormWidget({
    Key ?key,
    this.name = '',
    required this.dob,
    required this.onChangedName,
    required this.onChangedDob,
    required this.onSavedPlayer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildName(),
            SizedBox(height: 8),
            buildDob(),
            SizedBox(height: 16),
            buildButton(),
          ],
        ),
      );

  Widget buildName() => TextFormField(
        maxLines: 1,
        initialValue: name,
        onChanged: onChangedName,
        validator: (name) {
          if (name!.isEmpty) {
            return 'The Player name cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Player Name',
        ),
      );

  Widget buildDob() => DateTimeFormField(
        mode: DateTimeFieldPickerMode.date,
        autovalidateMode: AutovalidateMode.always,
        initialValue: dob,
        onDateSelected: onChangedDob,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Date of Birth',
        ),
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
          onPressed: onSavedPlayer,
          child: Text('Save'),
        ),
      );
}
