import 'package:practice_flutter_application_24/models/ToDoListMOdel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseServices {
  static Database? _db;
  static DatabaseServices instance = DatabaseServices._constructor();

  DatabaseServices._constructor();

  final String _tasksIdColumnName = "id";
  final String _tasksTableName = "tasks";
  final String _tasksTitleColumnName = "title";
  final String _tasksDescriptionColumnName = "description";
  final String _tasksDateColumnName = "date";

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initializeDatabase();
    print("Hiiiiiiiiiiiiii");
    print(_db);
    return _db!;
  }

  Future<Database> initializeDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "toDoList_db.db");
    final database = openDatabase(
      databasePath,
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

  //////////////////////////////////////////////////
  //////////////////////////////////////////////////
  Future<void> addTask(String title, String description, String date) async {
    print("In database Service to add the task");
    final Database db = await database;

    await db.insert(_tasksTableName, {
      _tasksTitleColumnName: title,
      _tasksDescriptionColumnName: description,
      _tasksDateColumnName: date,
    });
  }

  //////////////////////////////////////////////////
  //////////////////////////////////////////////////
  void updateMyTask(
    int id,
    String title,
    String description,
    String date,
  ) async {
    final Database db = await database;
    db.update(
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

  //////////////////////////////////////////////////
  //////////////////////////////////////////////////
  Future<List<ToDoListModelClass>> getMyTasks() async {
    final Database db = await database;
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

  //////////////////////////////////////////////////
  //////////////////////////////////////////////////
  void deleteTask(int id) async {
    Database db = await database;
    db.delete(_tasksTableName, where: "id = ?", whereArgs: [id]);
  }
}
