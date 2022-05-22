import 'package:flutter/material.dart';
import 'package:manabie_todolist/model/task_model.dart';
import 'package:manabie_todolist/theme/ui_color.dart';
import 'package:manabie_todolist/theme/ui_text_style.dart';

class TodoListItemWidget extends StatelessWidget {
  final Function()? onItemClicked;
  final Function(bool)? onChangeItemStatus;
  final TaskModel taskModel;
  const TodoListItemWidget({Key? key, this.onItemClicked, required this.taskModel, this.onChangeItemStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: ValueKey("ItemWidget"),
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onItemClicked?.call();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform.scale(
                scale: 1.4,
                child: Checkbox(
                  checkColor: UIColor.black,
                  activeColor: UIColor.black,
                  value: taskModel.isCompleted == 1,
                  shape: const CircleBorder(),
                  onChanged: (bool? value) {
                    onChangeItemStatus?.call(value ?? false);
                  },
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskModel.title ?? "",
                      style: (taskModel.isCompleted ?? 0) == 1 ? UITextStyle.grey_18_w700 : UITextStyle.black_18_w700,
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      taskModel.description ?? "",
                      style: (taskModel.isCompleted ?? 0) == 1 ? UITextStyle.grey_16_w400 : UITextStyle.black_16_w400,
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            taskModel.createdDate ?? "",
                            style: UITextStyle.grey_14_w400,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
