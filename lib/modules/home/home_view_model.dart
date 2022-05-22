import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manabie_todolist/modules/home/widgets/todo_list/todo_list_view.dart';
import 'package:manabie_todolist/shared/based/base_view_model.dart';

class HomeIndex {
  static const int all = 2;
  static const int complete = 1;
  static const int incomplete = 0;
}

class HomeViewModel extends BaseViewModel {
  final RxInt index = HomeIndex.all.obs;


  Widget getView() {
    switch(index.value) {
      case HomeIndex.all: 
      return const ToDoListView(status: HomeIndex.all);
      case HomeIndex.complete: 
      return const ToDoListView(status: HomeIndex.complete);
      case HomeIndex.incomplete: 
      return const ToDoListView(status: HomeIndex.incomplete);
      default: 
      return Container();
    }
  }
}
