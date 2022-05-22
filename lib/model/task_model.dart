import 'package:floor/floor.dart';

@entity
class TaskModel {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? title;
  String? description;
  String? createdDate;
  int? isCompleted;

  TaskModel({this.id, this.title, this.description, this.createdDate, this.isCompleted});

  TaskModel clone() {
    return TaskModel(
      id: id,
      title: title,
      description: description,
      createdDate: createdDate,
      isCompleted: isCompleted,
    );
  }
}
