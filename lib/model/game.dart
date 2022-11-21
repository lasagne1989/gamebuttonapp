final String tableGames = 'games';

class GameFields{
  static List<String> values = [
    id, gameN
  ];

  static String id = '_id';
  static String gameN = 'gameN';
}

class Game {
  String gameN;
  int? id;

  Game({
    required this.gameN,
    this.id,
  });

  Game copy({
  int? id,
  String? gameN,
}) =>
  Game(
    id: id ?? this.id,
    gameN: gameN ?? this.gameN,
  );

  static Game fromJson(Map<String, Object?> json) => Game(
    id: json[GameFields.id] as int?,
    gameN: json[GameFields.gameN] as String,
  );


  Map<String, Object?> toJson() => {
    GameFields.id: id,
    GameFields.gameN: gameN,
  };
}
