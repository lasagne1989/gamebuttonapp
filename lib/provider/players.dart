import 'package:flutter/cupertino.dart';
import '../model/player.dart';
import '../database/player_db.dart';

class PlayersProvider extends ChangeNotifier {
  List<Player> _players =[];

  List<Player> get players => _players.toList();

  List<Player> get playersPlaying =>
      _players.where((player) => player.isPlaying == true).toList();

  void setPlayers(List<Player> players) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _players = players;
        notifyListeners();
      });

  void addPlayer(Player player) async {
    _players.add(player);
    await PlayersDatabase.instance.create(player);
   notifyListeners();
  }

  void removePlayer(Player player) async {
    _players.remove(player);
    await PlayersDatabase.instance.delete(player.id!.toInt());
  notifyListeners();
}

  Future<bool> togglePlayerStatus(Player player) async {
   player.isPlaying = !player.isPlaying;
    await PlayersDatabase.instance.update(player);
   notifyListeners();
    return player.isPlaying;
  }

  void updatePlayer(Player player, String title, DateTime dob) {
    player.name = title;
    player.dob = dob;
   PlayersDatabase.instance.update(player);
   notifyListeners();
  }
}
