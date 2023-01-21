import 'package:flutter/material.dart';
import '../page/home_page.dart';
import 'package:provider/provider.dart';
import '../database/player_db.dart';
import '../provider/players.dart';
import '../widget/add_player_dialog_widget.dart';
import '../widget/player_list_widget.dart';
import '../model/player.dart';


class ForfeitList extends StatefulWidget {
  @override
  _ForfeitListState createState() => _ForfeitListState();
}

class _ForfeitListState extends State<ForfeitList> {
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
        title: Text("Add Your Forfeits"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.home,
                  color: Colors.red, size: 40),
              onPressed: _pushHome)
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
  void _pushHome() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return HomePage();
    }));
  }
}