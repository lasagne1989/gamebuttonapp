import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/player.dart';
import '../widget/player_form_widget.dart';
import '../provider/players.dart';

class EditPlayerPage extends StatefulWidget {
  final Player player;

  const EditPlayerPage({Key ?key, required this.player}) : super(key: key);

  @override
  _EditPlayerPageState createState() => _EditPlayerPageState();
}

class _EditPlayerPageState extends State<EditPlayerPage> {
  final _formKey = GlobalKey<FormState>();

  late String name;
  late DateTime dob;

  @override
  void initState() {
    super.initState();
    name = widget.player.name;
    dob = widget.player.dob;
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Text('Edit Player'),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                final provider =
                Provider.of<PlayersProvider>(context, listen: false);
                provider.removePlayer(widget.player);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: PlayerFormWidget(
              name: name,
              dob: dob,
              onChangedName: (name) => setState(() => this.name = name),
              onChangedDob: (dob) => setState(() => this.dob = dob),
              onSavedPlayer: savePlayer,
            ),
          ),
        ),
      );

  void savePlayer() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    else {
      final provider = Provider.of<PlayersProvider>(context, listen: false);
      provider.updatePlayer(widget.player, name, dob);

      Navigator.of(context).pop();
    }
  }
}
