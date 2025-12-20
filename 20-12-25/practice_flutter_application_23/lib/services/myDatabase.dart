import 'package:path/path.dart';
import 'package:practice_flutter_application_23/models/toDoListModel.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static DatabaseService instance = DatabaseService._constructor();

  DatabaseService._constructor();

  static Database? _db;

  final String _tasksTableName = "tasks";
  final String _tasksIdColumnName = 'id';
  final String _tasksTitleColumnName = "title";
  final String _tasksDescriptionColumnName = "description";
  final String _tasksDateColumnName = "date";

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initializeDatabase();
    return _db!;
  }

  Future<Database> initializeDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final dataBasePath = join(databaseDirPath, "toDoLis_db.db");
    final database = openDatabase(
      dataBasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $_tasksTableName(
          $_tasksIdColumnName INTEGER PRIMARY KEY,
          $_tasksTitleColumnName TEXT NOT NULL,
          $_tasksDescriptionColumnName TEXT NOT NULL,
          $_tasksDateColumnName TEXT NOT NULL
          )
      ''');
      },
    );
    return database;
  }

  /////////////////////////////////////////////////
  /////////////////////////////////////////////////

  void addTask(String title, String description, String date) async {
    final Database _db = await database;
    await _db.insert(_tasksTableName, {
      _tasksTitleColumnName: title,
      _tasksDescriptionColumnName: description,
      _tasksDateColumnName: date,
    });
  }

  /////////////////////////////////////////////////
  /////////////////////////////////////////////////
  void updateMyTask(
    int? id,
    String title,
    String description,
    String date,
  ) async {
    final Database _db = await database;
    await _db.update(
      _tasksTableName,
      {
        _tasksTitleColumnName: title,
        _tasksDescriptionColumnName: description,
        _tasksDateColumnName: date,
      },
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /////////////////////////////////////////////////
  /////////////////////////////////////////////////
  void deleteTask(int id) async {
    final Database _db = await database;
    _db.delete(_tasksTableName, where: "id = ?", whereArgs: [id]);
  }

  /////////////////////////////////////////////////
  /////////////////////////////////////////////////
  Future<List<ToDoListModel>> getMyTasks() async {
    final Database db = await database;
    final data = await db.query(_tasksTableName);

    List<ToDoListModel> tasks = data
        .map(
          (e) => ToDoListModel(
            id: e["id"] as int,
            title: e["title"] as String,
            description: e["description"] as String,
            date: e["date"] as String,
          ),
        )
        .toList();
    return tasks;
  }
}
