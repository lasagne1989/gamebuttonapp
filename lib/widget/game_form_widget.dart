import 'package:flutter/material.dart';

class GameFormWidget extends StatelessWidget {
  final String game;
  final ValueChanged<String> onChangedGame;
  final VoidCallback onSavedGame;

  const GameFormWidget({
    Key ?key,
    this.game = '',
    required this.onChangedGame,
    required this.onSavedGame,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildName(),
            SizedBox(height: 8),
            buildButton(),
          ],
        ),
      );

  Widget buildName() => TextFormField(
        maxLines: 1,
        initialValue: game,
        onChanged: onChangedGame,
        validator: (name) {
          if (name!.isEmpty) {
            return 'The Game name cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Game',
          filled: true,
          fillColor: Colors.grey.shade300,
        ),
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
          onPressed: onSavedGame,
          child: Text('Save'),
        ),
      );
}
