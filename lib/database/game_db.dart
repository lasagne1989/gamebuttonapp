import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/game.dart';

class GamesDatabase {
  static final GamesDatabase instance = GamesDatabase._init();

  static Database? _database;

  GamesDatabase._init();

  Future<Database> get database async {
    if (_database!=null) return _database !;

    _database = await _initDB('games.db');
    return _database!;
    }

    Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path =join(dbPath,filePath);

    return await openDatabase(path, version:1, onCreate: _createDB);
    }

    Future _createDB(Database db, int version) async {
      final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
      final textType = 'TEXT NOT NULL';
    await db.execute('''
      CREATE TABLE $tableGames (
      ${GameFields.id} $idType,
      ${GameFields.gameN} $textType,      
      )
     ''');
    }

    Future<Game> create(Game game) async{
    final db = await instance.database;

    final id = await db.insert(tableGames, game.toJson());
    return game.copy(id: id);
    }

    Future<Game> readGame(int id) async {
      final db =await instance.database;

      final maps = await db.query(
        tableGames,
        columns: GameFields.values,
        where: '${GameFields.id} = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty){
        return Game.fromJson(maps.first);
      } else{
        throw Exception('ID $id not found');
      }
    }

    Future<List<Game>> readAllGames() async {
      final db = await instance.database;
      final orderBy = '${GameFields.gameN} ASC';
      final result = await db.query(tableGames, orderBy: orderBy);
      return result.map((json) => Game.fromJson(json)).toList();
    }

    Future<int> update(Game game) async {
      final db = await instance.database;
      return db.update(
        tableGames,
        game.toJson(),
        where: '${GameFields.id} = ?',
        whereArgs: [game.id],
      );
    }

    Future<int> delete(int id) async{
      final db = await instance.database;
      return await db.delete(
        tableGames,
        where: '${GameFields.id} = ?',
        whereArgs: [id],
      );
    }

    Future close() async{
      final db = await instance.database;
      db.close();
    }
}
