import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manabie_todolist/modules/home/widgets/todo_list/todo_list_view_model.dart';
import 'package:manabie_todolist/modules/home/widgets/todo_list_item_widget.dart';
import 'package:manabie_todolist/shared/based/base_view_state.dart';
import 'package:manabie_todolist/theme/ui_color.dart';
import 'package:manabie_todolist/theme/ui_text_style.dart';

class ToDoListView extends StatefulWidget {
  final int status;
  const ToDoListView({Key? key,required this.status}) : super(key: key);

  @override
  State<ToDoListView> createState() => _ToDoListViewState();
}

class _ToDoListViewState extends BaseViewState<ToDoListView, TodoListViewModel> {
  @override
  TodoListViewModel createViewModel() => TodoListViewModel();

  @override
  void loadArguments() {
    viewModel.status = widget.status;
    viewModel.getData();
    super.loadArguments();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(
      () => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: UIColor.black,
          middle: const Text(
            "Todo List",
            style: UITextStyle.white_20_w700,
          ),
          trailing: IconButton(
            padding: const EdgeInsets.only(bottom: 6.0),
            icon: const Icon(
              CupertinoIcons.add,
              color: UIColor.white,
            ),
            onPressed: viewModel.onAddBtnClicked,
          ),
        ),
        backgroundColor: UIColor.white,
        child: SizedBox(
          width: double.infinity,
          child: viewModel.tasks.toList().isEmpty
              ? const Center(
                  child: Text(
                    "Không có công việc",
                    style: UITextStyle.grey_16_w400,
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0, bottom: 32.0),
                  itemCount: viewModel.tasks.toList().length,
                  itemBuilder: (context, index) => TodoListItemWidget(
                    taskModel: viewModel.tasks[index],
                    onChangeItemStatus: (status) => viewModel.onChangeItemStatus(index, status),
                    onItemClicked: () => viewModel.onItemClicked(index),
                  ),
                ),
        ),
      ),
    );
  }
}
