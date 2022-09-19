final String tablePlayers = 'players';

class PlayerFields{
  static List<String> values = [
    id, name, dob, isPlaying
  ];

  static String id = '_id';
  static String name = 'name';
  static String dob = 'dob';
  static String isPlaying = 'isPlaying';
}

class Player {
  //DateTime createdTime;
  String name;
  int? id;
  DateTime dob;
  bool isPlaying;

  Player({
    //required this.createdTime,
    required this.name,
    required this.dob,
    this.id,
    this.isPlaying = false,
  });

  Player copy({
  int? id,
  String? name,
  DateTime? dob,
  bool? isPlaying,
}) =>
  Player(
    id: id ?? this.id,
    name: name ?? this.name,
    dob: dob ?? this.dob,
    isPlaying: isPlaying ?? this.isPlaying
  );

  static Player fromJson(Map<String, Object?> json) => Player(
    id: json[PlayerFields.id] as int?,
    name: json[PlayerFields.name] as String,
    dob: DateTime.parse(json[PlayerFields.dob] as String),
    isPlaying: json[PlayerFields.isPlaying] == 1
  );


  Map<String, Object?> toJson() => {
    PlayerFields.id: id,
    PlayerFields.name: name,
    PlayerFields.dob: dob.toIso8601String(),
    PlayerFields.isPlaying: isPlaying ? 1 : 0
  };
}
