import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/game.dart';
import '../provider/games.dart';
import '../widget/game_form_widget.dart';

class AddGamesDialogWidget extends StatefulWidget {
  @override
  _AddGamesDialogWidgetState createState() => _AddGamesDialogWidgetState();
}

class _AddGamesDialogWidgetState extends State<AddGamesDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String gameN = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Game',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              GameFormWidget(
                onChangedGame: (game) => setState(() => this.gameN = game),
                onSavedGame: addGame,
              ),
            ],
          ),
        ),
      );

  void addGame() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final game = Game(
          gameN: gameN,
      );
      final provider = Provider.of<GamesProvider>(context, listen: false);
      provider.addGame(game);

      Navigator.of(context).pop();
    }
  }
}
