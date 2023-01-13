import 'package:flutter/cupertino.dart';
import '../model/game.dart';
import '../database/game_db.dart';

class GamesProvider extends ChangeNotifier {
  List<Game> _games =[];

  List<Game> get games => _games.toList();


  void setGames(List<Game> games) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _games = games;
        notifyListeners();
      });

  void addGame(Game game) async {
    _games.add(game);
    await GamesDatabase.instance.create(game);
   notifyListeners();
  }

  void removeGame(Game game) async {
    _games.remove(game);
    await GamesDatabase.instance.delete(game.id!.toInt());
  notifyListeners();
}

  void updateGame(Game game, String title) {
    game.gameN = title;
    GamesDatabase.instance.update(game);
   notifyListeners();
  }
}
