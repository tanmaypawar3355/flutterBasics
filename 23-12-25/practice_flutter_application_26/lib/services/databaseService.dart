import 'package:practice_flutter_application_26/models/toDoListModelClass.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Databaseservice {
  static Databaseservice instance = Databaseservice._constructor();
  Databaseservice._constructor();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initializeDatabase();
    return _db!;
  }

  final String _tasksTableName = "tasks";
  final String _tasksIdColumnName = "id";
  final String _tasksTitleColumnName = "title";
  final String _tasksDescriptionColumnName = "description";
  final String _tasksDateColumnName = "date";

  Future<Database> initializeDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "to_do_lis_db._db");
    final database = openDatabase(
      databasePath,
      version: 1,
      onCreate: (_db, version) {
        _db.execute('''
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

  void addTask(String title, String description, String date) async {
    final db = await database;
    db.insert(_tasksTableName, {
      _tasksTitleColumnName: title,
      _tasksDescriptionColumnName: description,
      _tasksDateColumnName: date,
    });
  }

  //////////////////////////////////
  //////////////////////////////////
  /// Getting the data from the database
  Future<List<ToDoListModelClass>> getMyTasks() async {
    final db = await database;
    final data = await db.query(_tasksTableName);

    List<ToDoListModelClass> tasks = data
        .map(
          (e) => ToDoListModelClass(
            id: e["id"] as int,
            title: e["title"] as String,
            description: e["description"] as String,
            date: e["date"] as String,
          ),
        )
        .toList();

    return tasks;
  }

  //////////////////////////////////
  //////////////////////////////////
  /// Editing the data from the database
  void editTask(int id, String title, String description, String date) async {
    final db = await database;
    db.update(
      _tasksTableName,
      {
        _tasksTitleColumnName: title,
        _tasksDescriptionColumnName: description,
        _tasksDateColumnName: date,
      },
      where: "id =?",
      whereArgs: [id],
    );
  }

  //////////////////////////////////
  //////////////////////////////////
  /// Deleting the data from the database
  void deleteTask(int id) async {
    final db = await database;
    db.delete(_tasksTableName, where: "id =?", whereArgs: [id]);
  }
}
