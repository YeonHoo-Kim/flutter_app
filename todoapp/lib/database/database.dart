import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/models/todo.dart';

class DatabaseHelper {
  Future<Database> database() async {
    return openDatabase(
      // 데이터베이스 경로를 지정합니다. 참고: `path` 패키지의 `join` 함수를 사용하는 것이
      // 각 플랫폼 별로 경로가 제대로 생성됐는지 보장할 수 있는 가장 좋은 방법입니다
      join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)",
        );
        await db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY, taskId INTEGER, title TEXT, isDone INTEGER)",
        );
        // return db;
      },
      version: 1,
    );
  }

  Future<List<Task>> getTasks() async {
    Database db = await database();
    List<Map<String, dynamic>> taskMap = await db.query('tasks');
    return List.generate(taskMap.length, (index) {
      return Task(
        id: taskMap[index]['id'],
        title: taskMap[index]['title'],
        description: taskMap[index]['description'],
      );
    });
  }

  Future<int> insertTask(Task task) async {
    Database db = await database();
    int taskId = 0;
    await db
        .insert("tasks", task.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      taskId = value;
    });
    return taskId;
  }

  Future<void> deleteTask(int id) async {
    Database db = await database();
    await db.rawDelete("DELETE FROM tasks WHERE id = $id");
    await db.rawDelete("DELETE FROM todos WHERE taskId = $id");
  }

  Future<void> updateTaskTitle(int id, String title) async {
    Database db = await database();
    await db.rawUpdate("UPDATE tasks SET title = '$title' WHERE id = $id");
  }

  Future<void> updateTaskDescription(int id, String description) async {
    Database db = await database();
    await db.rawUpdate(
        "UPDATE tasks SET description = '$description' WHERE id = $id");
  }

  Future<List<Todo>> getTodos(int taskId) async {
    Database db = await database();
    List<Map<String, dynamic>> todoMap =
        await db.rawQuery("SELECT * FROM todos WHERE taskId = $taskId");
    return List.generate(todoMap.length, (index) {
      return Todo(
        id: todoMap[index]['id'],
        taskId: todoMap[index]['taskId'],
        title: todoMap[index]['title'],
        isDone: todoMap[index]['isDone'],
      );
    });
  }

  Future<void> insertTodo(Todo todo) async {
    Database db = await database();
    await db.insert("todos", todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateTodoDone(int id, int isDone) async {
    Database db = await database();
    await db.rawUpdate("UPDATE todos SET isDone = $isDone WHERE id = $id");
  }
}
