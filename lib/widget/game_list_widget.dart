import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/game_widget.dart';
import '../provider/games.dart';

class GameListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GamesProvider>(context);
    final games = provider.games;

    return games.isEmpty
        ? Center(
            child: Text(
              'Add Games',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];
              return GameWidget(game: game);

            },
          );
  }
}
