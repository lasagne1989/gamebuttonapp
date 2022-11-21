import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../provider/games.dart';
import '../model/game.dart';
import '../utils.dart';


class GameWidget extends StatelessWidget {
  final Game game;
  GameWidget({
    required this.game,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
            endActionPane: ActionPane(
            motion: const DrawerMotion(),
            extentRatio: 0.25,
            children:[
            SlidableAction(
              backgroundColor: Colors.redAccent,
              label: 'Delete',
              onPressed: (context) => deletePlayer(context, game),
              icon: Icons.delete,
            )
          ],
          ),
          child: buildPlayer(context),
        ),
      );

  Widget buildPlayer(BuildContext context) => GestureDetector(
        child: Container(
          color: Colors.grey[900],
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game.gameN,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );


  void deletePlayer(BuildContext context, Game game) {
    final provider = Provider.of<GamesProvider>(context, listen: false);
        provider.removeGame(game);
        Utils.showSnackBar(context, 'Deleted the Game');
  }
}
