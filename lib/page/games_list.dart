import 'package:flutter/material.dart';
import '../page/home_page.dart';
import 'package:provider/provider.dart';
import '../database/game_db.dart';
import '../provider/games.dart';
import '../widget/add_game_dialog_widget.dart';
import '../widget/game_list_widget.dart';
import '../model/game.dart';


class GamesList extends StatefulWidget {
  @override
  _GamesListState createState() => _GamesListState();
}

class _GamesListState extends State<GamesList> {
  late List<Game> games;
  bool isLoading = false;

  @override
  void initState(){
    super.initState();
    refreshGames();
  }


  @override
  void dispose() {
    GamesDatabase.instance.close();
    super.dispose();
  }

  Future refreshGames() async {
    setState(() => isLoading = true);
    this.games = await GamesDatabase.instance.readAllGames();
    final provider = Provider.of<GamesProvider>(context,listen: false);
    provider.setGames(games);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Your Games"),
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
          : GameListWidget(),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.red,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddGamesDialogWidget(),
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