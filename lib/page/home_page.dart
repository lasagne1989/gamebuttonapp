import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/player_db.dart';
import '../provider/players.dart';
import '../widget/add_player_dialog_widget.dart';
import '../widget/player_list_widget.dart';
import 'playing_list.dart';
import '../model/player.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Player> players;
  bool isLoading = false;

  @override
  void initState(){
     super.initState();
     refreshPlayers();
  }


  @override
  void dispose() {
    PlayersDatabase.instance.close();
    super.dispose();
  }

  Future refreshPlayers() async {
    setState(() => isLoading = true);
    this.players = await PlayersDatabase.instance.readAllPlayers();
    final provider = Provider.of<PlayersProvider>(context,listen: false);
    provider.setPlayers(players);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Your Players"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_circle_right_rounded,
                  color: Colors.red, size: 40),
              onPressed: _pushPlaying)
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: isLoading ?
      Center(child: CircularProgressIndicator())
      : PlayerListWidget(),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.red,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddPlayerDialogWidget(),
          barrierDismissible: false,
        ),
        child: Icon(Icons.add),
      ),
    );

  }
  void _pushPlaying() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return PlayingListWidget();
    }));
  }

}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
