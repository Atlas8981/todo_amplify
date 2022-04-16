
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_amplify/components/sub_textfield.dart';
import 'package:todo_amplify/components/title_textfield.dart';
import 'package:todo_amplify/controllers/task_type_controller.dart';
import 'package:todo_amplify/models/Task.dart';
import 'package:todo_amplify/models/TaskType.dart';
import 'package:todo_amplify/services/TaskService.dart';
import 'package:todo_amplify/utils/constant.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final taskService= TaskService();
  final taskListController = Get.find<TaskTypeController>();
  final editForm = GlobalKey<FormState>();
  final taskNameCon = TextEditingController(),
      detailCon = TextEditingController(),
      dateTimeCon = TextEditingController();
  late TaskType selectedTypeOfTask = taskListController.taskTypes[0];

  Widget customDropDownButton() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: DropdownButton<TaskType>(
        dropdownColor: Colors.grey.shade800,
        underline: Container(),
        isDense: true,
        iconEnabledColor: Colors.white,
        borderRadius: BorderRadius.circular(8),
        value: selectedTypeOfTask,
        items: taskListController.taskTypes.map((TaskType value) {
          return DropdownMenuItem<TaskType>(
            value: value,
            child: Text(
              value.name ?? "",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value == null) {
            return;
          }
          setState(() {
            selectedTypeOfTask = value;
            print(value);
          });
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    taskNameCon.text = widget.task.name ?? "";
    detailCon.text = widget.task.description ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: editForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customDropDownButton(),
              TitleTextField(
                controller: taskNameCon,
                hintText: "(Task Name)",
              ),
              SubTextField(
                controller: detailCon,
                hintText: "Add Details",
                prefixIcons: Icons.view_headline,
              ),
              SubTextField(
                controller: dateTimeCon,
                hintText: "Add date/time",
                prefixIcons: Icons.event_available,
              ),
              SubTextField(
                controller: TextEditingController(),
                hintText: "Add subtasks",
                prefixIcons: Icons.subdirectory_arrow_right,
                enableInteractiveSelection: false,
                focusNode: AlwaysDisabledFocusNode(),
                onTap: () {

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
