import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/player_widget.dart';
import '../provider/players.dart';

class PlayerListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlayersProvider>(context);
    final players = provider.players;

    return players.isEmpty
        ? Center(
            child: Text(
              'Add Players to your game.',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: players.length,
            itemBuilder: (context, index) {
              final player = players[index];
              return PlayerWidget(player: player);

            },
          );
  }
}
