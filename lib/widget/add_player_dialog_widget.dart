import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/player.dart';
import '../provider/players.dart';
import '../widget/player_form_widget.dart';

class AddPlayerDialogWidget extends StatefulWidget {
  @override
  _AddPlayerDialogWidgetState createState() => _AddPlayerDialogWidgetState();
}

class _AddPlayerDialogWidgetState extends State<AddPlayerDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  DateTime dob = DateTime.now();

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Player',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              PlayerFormWidget(
                onChangedName: (name) => setState(() => this.name = name),
                onChangedDob: (dob) => setState(() => this.dob = dob),
                onSavedPlayer: addPlayer, dob: dob,
              ),
            ],
          ),
        ),
      );

  void addPlayer() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final player = Player(
          //id: DateTime.now().toInt(),
          name: name,
          dob: dob,
          isPlaying: true
      );
      final provider = Provider.of<PlayersProvider>(context, listen: false);
      provider.addPlayer(player);

      Navigator.of(context).pop();
    }
  }
}
