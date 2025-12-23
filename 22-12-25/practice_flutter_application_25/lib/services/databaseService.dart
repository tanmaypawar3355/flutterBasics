import 'package:path/path.dart';
import 'package:practice_flutter_application_25/models/toDoListModelClass.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseServices {
  Database? db;
  static final DatabaseServices instance = DatabaseServices._constructor();

  DatabaseServices._constructor();

  Future<Database> get database async {
    if (db != null) return db!;
    db = await initializeDatabase();
    return db!;
  }

  final String _tasksTableName = "tasks";
  final String _tasksIdColumnName = "id";
  final String _tasksTitleColumnName = "title";
  final String _tasksDescriptionColumnName = "description";
  final String _tasksDateColumnName = "date";

  Future<Database> initializeDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "to-doList_db.db");
    final database = openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
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
  /// Adding the new task in the database.
  void addTheTask(String title, String description, String date) async {
    final db = await database;
    db.insert(_tasksTableName, {
      _tasksTitleColumnName: title,
      _tasksDescriptionColumnName: description,
      _tasksDateColumnName: date,
    });
  }

  //////////////////////////////////
  //////////////////////////////////
  /// Updating the existing task in the database.
  void updateMyTask(
    int id,
    String title,
    String description,
    String date,
  ) async {
    final db = await database;
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

  //////////////////////////////////
  //////////////////////////////////
  /// Getting the existing tasks saved in the database.
  Future<List<ToDoListModelClass>> getMyTask() async {
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
  /// Delete task
  void deleteTask(int id) async {
    final db = await database;
    db.delete(_tasksTableName,
    where: "id = ?",
    whereArgs: [id],
    );
  }
}
