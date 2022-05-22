import 'package:floor/floor.dart';
import 'package:manabie_todolist/model/task_model.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM TaskModel')
  Future<List<TaskModel>> findAllTasks();

  @Query('SELECT * FROM TaskModel WHERE id = :id')
  Stream<TaskModel?> findTaskById(int id);

  @Query('SELECT * FROM TaskModel WHERE isCompleted = :isCompleted')
  Future<List<TaskModel>> getListTaskModelByStatus(int isCompleted);

  @insert
  Future<void> insertTask(TaskModel task);

  @update
  Future<void> updateTask(TaskModel task);

  @delete
  Future<void> deleteTask(TaskModel task);
}
