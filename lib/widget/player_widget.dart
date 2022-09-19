import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../provider/players.dart';
import '../model/player.dart';
import '../page/edit_players_page.dart';
import '../utils.dart';


class PlayerWidget extends StatelessWidget {
  final Player player;
  PlayerWidget({
    required this.player,
    Key? key,
  }) : super(key: key);

  late DateTime playerDob = player.dob;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          startActionPane: ActionPane(
          key: Key(player.id.toString()),
            motion: const DrawerMotion(),
            extentRatio: 0.25,
            children: [
            SlidableAction(
              backgroundColor: Colors.green,
              onPressed: (context) => editPlayer(context, player),
              label: 'Edit',
              icon: Icons.edit,
            )
          ],
          ),
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            extentRatio: 0.25,
            children:[
            SlidableAction(
              backgroundColor: Colors.redAccent,
              label: 'Delete',
              onPressed: (context) => deletePlayer(context, player),
              icon: Icons.delete,
            )
          ],
          ),
          child: buildPlayer(context),
        ),
      );

  Widget buildPlayer(BuildContext context) => GestureDetector(
        onTap: () => playingPlayer(context, player),
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
                      player.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text('Date of Birth: $playerDob',
                          style: TextStyle(fontSize: 20, height: 1.5, color: Colors.white),
                        ),
                      )
                  ],
                ),
              ),
      Icon(
        player.isPlaying ? Icons.check_box : Icons.add_rounded,
        size: 40.0,
        color: player.isPlaying ? Colors.green : null,
      ),
            ],
          ),
        ),
      );

  void playingPlayer(BuildContext context, Player player) {
    final provider = Provider.of<PlayersProvider>(context, listen: false);
    provider.togglePlayerStatus(player);
    player.isPlaying ?
    Utils.showSnackBar(context, 'You are in the game') : Utils.showSnackBar(context, 'You are out the game');
  }

  void deletePlayer(BuildContext context, Player player) {
    final provider = Provider.of<PlayersProvider>(context, listen: false);
        provider.removePlayer(player);

        Utils.showSnackBar(context, 'Deleted the Player');
  }

  void editPlayer(BuildContext context, Player player) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditPlayerPage(player: player),
        ),
      );
}
