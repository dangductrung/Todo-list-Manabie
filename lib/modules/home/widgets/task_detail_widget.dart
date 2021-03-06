import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_service/keyboard_service.dart';
import 'package:manabie_todolist/helpers/toast_helper.dart';
import 'package:manabie_todolist/model/task_model.dart';
import 'package:manabie_todolist/theme/ui_color.dart';
import 'package:manabie_todolist/theme/ui_text_style.dart';

class TaskDetailWidget extends StatelessWidget {
  final TaskModel? task;
  final Function(TaskModel)? onSaveBtnClicked;
  final Function(TaskModel)? onCreateBtnClicked;
  final Function(TaskModel)? onDeleteBtnClicked;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  const TaskDetailWidget(
      {Key? key, this.task, this.onSaveBtnClicked, this.onDeleteBtnClicked, this.onCreateBtnClicked, required this.titleController, required this.descriptionController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskModel? taskModel = task?.clone() ?? TaskModel();
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        KeyboardService.dismiss(unfocus: context);
      },
      child: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: UIColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(5.0),
          ),
        ),
        child: Container(
          color: UIColor.grey.withAlpha(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 8.0,
              ),
              Container(
                height: 8.0,
                width: 70.0,
                decoration: BoxDecoration(
                  color: UIColor.grey.withAlpha(70),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              const Text(
                "Chi ti???t",
                style: UITextStyle.black_20_w700,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: UIColor.white,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: Column(
                  children: [
                    TextField(
                      key: ValueKey("titleTextField"),
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: "Ti??u ?????",
                        hintStyle: UITextStyle.grey_16_w400,
                        isDense: false,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: UIColor.grey.withAlpha(70)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: UIColor.grey.withAlpha(70)),
                        ),
                      ),
                      style: UITextStyle.black_16_w400,
                      onChanged: (text) => {taskModel.title = text},
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      key: ValueKey("descriptionTextField"),
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: "M?? t???",
                        hintStyle: UITextStyle.grey_16_w400,
                        isDense: false,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: UIColor.grey.withAlpha(70)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: UIColor.grey.withAlpha(70)),
                        ),
                      ),
                      style: UITextStyle.black_16_w400,
                      onChanged: (text) => {taskModel.description = text},
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 16.0,
                  ),
                  if (task != null)
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showCupertinoDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (ctx) => CupertinoAlertDialog(
                                    title: const Text(
                                      "X??c nh???n",
                                      style: UITextStyle.black_18_w700,
                                    ),
                                    content: const Text(
                                      "B???n mu???n xo?? c??ng vi???c?",
                                      style: UITextStyle.black_16_w400,
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: const Text(
                                          "C??",
                                          style: UITextStyle.red_16_w400,
                                        ),
                                        onPressed: () {
                                          Get.back();
                                          onDeleteBtnClicked?.call(taskModel);
                                          Get.back();
                                        },
                                      ),
                                      CupertinoDialogAction(
                                        child: const Text(
                                          "Kh??ng",
                                          style: UITextStyle.black_16_w400,
                                        ),
                                        onPressed: () {
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              behavior: HitTestBehavior.translucent,
                              child: Container(
                                height: 50.0,
                                margin: const EdgeInsets.symmetric(vertical: 16.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: UIColor.red,
                                ),
                                child: const Center(
                                  child: Text(
                                    "Xo??",
                                    style: UITextStyle.white_16_w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                        ],
                      ),
                    ),
                  Expanded(
                    child: GestureDetector(
                      key: ValueKey("SaveBtn"),
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        if (taskModel.title == null || (taskModel.title ?? "") == "") {
                          ToastHelper.showToast(msg: "H??y nh???p ti??u ?????", isTrue: false);
                          return;
                        }

                        if (taskModel.description == null || (taskModel.description ?? "") == "") {
                          ToastHelper.showToast(msg: "H??y nh???p m?? t???", isTrue: false);
                          return;
                        }
                        showCupertinoDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (ctx) => CupertinoAlertDialog(
                            title: const Text(
                              "X??c nh???n",
                              style: UITextStyle.black_18_w700,
                            ),
                            content: const Text(
                              "B???n mu???n l??u thay ?????i?",
                              style: UITextStyle.black_16_w400,
                            ),
                            actions: [
                              CupertinoDialogAction(
                                key: ValueKey("SaveConfirmYesBtn"),
                                child: const Text(
                                  "C??",
                                  style: UITextStyle.blue_16_w400,
                                ),
                                onPressed: () {
                                  Get.back();
                                  if (task == null) {
                                    onCreateBtnClicked?.call(taskModel);
                                  } else {
                                    onSaveBtnClicked?.call(taskModel);
                                  }
                                  Get.back();
                                },
                              ),
                              CupertinoDialogAction(
                                key: ValueKey("SaveConfirmNoBtn"),
                                child: const Text(
                                  "Kh??ng",
                                  style: UITextStyle.black_16_w400,
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        height: 50.0,
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: UIColor.blue,
                        ),
                        child: Center(
                          child: Text(
                            task == null ? "Th??m" : "L??u",
                            style: UITextStyle.white_16_w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
