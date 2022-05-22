import 'dart:async';
import 'package:floor/floor.dart';
import 'package:manabie_todolist/dao/task_dao.dart';
import 'package:manabie_todolist/model/task_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [TaskModel])
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDao;
}

class DatabaseHelper {
  DatabaseHelper._();

  static AppDatabase? _database;

  static Future<AppDatabase> get database async {
    _database ??= await $FloorAppDatabase.databaseBuilder('manabie_todolist').addMigrations(
      [],
    ).build();

    return _database!;
  }

  static Future<List<TaskModel>> getListTaskModel() async {
    final AppDatabase db = await database;
    return await db.taskDao.findAllTasks();
  }

  static Future<List<TaskModel>> getListTaskModelByStatus(int isCompleted) async {
    final AppDatabase db = await database;
    return await db.taskDao.getListTaskModelByStatus(isCompleted);
  }

  static Future<void> insertTask(TaskModel task) async {
    final AppDatabase db = await database;
    return await db.taskDao.insertTask(task);
  }

  static Future<void> updateTask(TaskModel task) async {
    final AppDatabase db = await database;
    return await db.taskDao.updateTask(task);
  }

  static Future<void> deleteTask(TaskModel task) async {
    final AppDatabase db = await database;
    return await db.taskDao.deleteTask(task);
  }
}
