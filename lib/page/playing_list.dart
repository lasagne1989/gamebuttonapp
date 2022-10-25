import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/player.dart';
import '../provider/players.dart';
import 'final_settings.dart';

class PlayingListWidget extends StatefulWidget {
  @override
  _PlayingListWidgetState createState() => _PlayingListWidgetState();
}

class _PlayingListWidgetState extends State<PlayingListWidget> {
  late List<Player> playing = [];

  @override
  void didChangeDependencies() async {
    final provider = Provider.of<PlayersProvider>(context);
    playing = provider.playersPlaying;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get the Players in Order"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_circle_right_rounded,
                  color: Colors.red, size: 40),
              onPressed: _showPlaying)
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ReorderableListView.builder(
        itemCount: playing.length,
        onReorder: (oldIndex, newIndex) =>
            setState(() {
              final index = newIndex > oldIndex ? newIndex - 1 : newIndex;

              final player = playing.removeAt(oldIndex);
              playing.insert(index, player);
            }),
        itemBuilder: (context, index) {
          final player = playing[index];
          return buildPlayer(index, player);
        },
      ),
    );
  }

  Widget buildPlayer(int index, Player player) =>
      ListTile(
          key: ValueKey(player),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          title: Text(player.name, style: const TextStyle(fontSize:20, color: Colors.white)),
          tileColor: Colors.black,
        );

  void _showPlaying() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return GameSettings(playing: playing);
        }
    )
    );
  }
}

