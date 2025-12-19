import 'package:path/path.dart';
import 'package:practice_flutter_application_22/models/toDoListModel.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseServices {
  static Database? _db;
  static DatabaseServices instance = DatabaseServices._constructor();

  DatabaseServices._constructor();

  String _tasksTableName = "tasks";
  String _tasksTitleColumName = "title";
  String _tasksDescriptionColumnName = "description";
  String _tasksDateColumnName = "date";
  String _tasksIdColumnName = "id";

  Future get database async {
    if (_db != null) return _db!;
    _db = await initializeDatabase();
    return _db;
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
        $_tasksTitleColumName TEXT NOT NULL,
        $_tasksDescriptionColumnName TEXT NOT NULL,
        $_tasksDateColumnName TEXT NOT NULL
        )
        ''');
      },
    );
    return database;
  }

  Future<void> addTask(String title, String description, String date) async {
    final Database db = await database;

    await db.insert(_tasksTableName, {
      _tasksTitleColumName: title,
      _tasksDescriptionColumnName: description,
      _tasksDateColumnName: date,
    });
  }

  Future<List<TodoListModel>> getMyTasks() async {
    final Database db = await database;
    final data = await db.query(_tasksTableName);

    print("$data\n");
    List<TodoListModel> tasks = data
        .map(
          (e) => TodoListModel(
            id: e["id"] as int,
            title: e["title"] as String,
            description: e["description"] as String,
            date: e["date"] as String,
          ),
        )
        .toList();
    return tasks;
  }

  void updateMyTask(
    int? id,
    String title,
    String description,
    String date,
  ) async {
    final Database db = await database;
    await db.update(
      _tasksTableName,
      {
        _tasksTitleColumName: title,
        _tasksDescriptionColumnName: description,
        _tasksDateColumnName: date,
      },
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteTask(int id) async {
    final Database db = await database;
    await db.delete(_tasksTableName, where: 'id = ?', whereArgs: [id]);
  }
}
