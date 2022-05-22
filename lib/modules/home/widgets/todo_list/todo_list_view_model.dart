import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manabie_todolist/database/database.dart';
import 'package:manabie_todolist/helpers/toast_helper.dart';
import 'package:manabie_todolist/model/task_model.dart';
import 'package:manabie_todolist/modules/home/home_view_model.dart';
import 'package:manabie_todolist/modules/home/widgets/task_detail_widget.dart';
import 'package:manabie_todolist/shared/based/base_view_model.dart';
import 'package:intl/intl.dart';

class TodoListViewModel extends BaseViewModel {
  late int status;

  final _tasks = <TaskModel>[].obs;
  List<TaskModel> get tasks => _tasks.toList();

  void getData() {
    call(() async {
      if (status == HomeIndex.all) {
        _tasks.assignAll(await DatabaseHelper.getListTaskModel());
      } else {
        _tasks.assignAll(await DatabaseHelper.getListTaskModelByStatus(status == HomeIndex.complete ? 1 : 0));
      }
      _tasks.refresh();
    });
  }

  void onAddBtnClicked({TaskModel? taskModel}) {
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (BuildContext context) {
        return TaskDetailWidget(
          onSaveBtnClicked: onSaveBtnClicked,
          onCreateBtnClicked: onCreateBtnClicked,
          onDeleteBtnClicked: onDeleteBtnClicked,
          task: taskModel,
          titleController: TextEditingController(text: taskModel?.title ?? ""),
          descriptionController: TextEditingController(text: taskModel?.description ?? ""),
        );
      },
    );
  }

  void onSaveBtnClicked(TaskModel taskModel) {
    call(() async {
      await DatabaseHelper.updateTask(taskModel);
      _tasks[_tasks.indexWhere((element) => element.id == taskModel.id)] = taskModel;
      _tasks.refresh();
      ToastHelper.showToast(msg: "Cập nhật công việc thành công");
    });
  }

  void onCreateBtnClicked(TaskModel taskModel) {
    call(() async {
      String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
      taskModel.createdDate = formattedDate;
      taskModel.isCompleted = 0;
      await DatabaseHelper.insertTask(taskModel);
      _tasks.add(taskModel);
      getData();
      ToastHelper.showToast(msg: "Thêm công việc thành công");
    });
  }

  void onDeleteBtnClicked(TaskModel taskModel) {
    call(() async {
      await DatabaseHelper.deleteTask(taskModel);
      _tasks.removeWhere((task) => task.id == taskModel.id);
      _tasks.refresh();
      ToastHelper.showToast(msg: "Xoá công việc thành công");
    });
  }

  void onChangeItemStatus(int index, bool status) {
    call(
      () async {
        _tasks[index].isCompleted = status ? 1 : 0;
        await DatabaseHelper.updateTask(_tasks[index]);
        getData();
      },
      background: true,
    );
  }

  void onItemClicked(int index) {
    onAddBtnClicked(taskModel: tasks[index]);
  }
}
