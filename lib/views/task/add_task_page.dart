import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_amplify/components/date_time_picker.dart';
import 'package:todo_amplify/components/sub_textfield.dart';
import 'package:todo_amplify/components/title_textfield.dart';
import 'package:todo_amplify/controllers/task_type_controller.dart';
import 'package:todo_amplify/models/Task.dart';
import 'package:todo_amplify/services/TaskService.dart';
import 'package:todo_amplify/utils/constant.dart';

import '../../models/TaskType.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final taskService = TaskService();
  final taskListController = Get.find<TaskTypeController>();
  final addForm = GlobalKey<FormState>();
  final taskNameCon = TextEditingController(),
      detailCon = TextEditingController(),
      dateTimeCon = TextEditingController();
  late TaskType selectedTaskType = taskListController.taskTypes[0];

  Widget customDropDownButton() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: DropdownButton<TaskType>(
        dropdownColor: Colors.grey.shade800,
        underline: Container(),
        isDense: true,
        iconEnabledColor: Colors.white,
        borderRadius: BorderRadius.circular(8),
        value: selectedTaskType,
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
            selectedTaskType = value;
            print(value);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () async {
              onCheckButtonTap();
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: addForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
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
                enableInteractiveSelection: false,
                focusNode: AlwaysDisabledFocusNode(),
                onTap: () {
                  _selectDate(context);
                },
              ),
              SubTextField(
                controller: TextEditingController(),
                hintText: "Add subtasks",
                prefixIcons: Icons.subdirectory_arrow_right,
                enableInteractiveSelection: false,
                focusNode: AlwaysDisabledFocusNode(),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime? selectedDate;

  void _selectDate(BuildContext context) {
    showCustomDateTimePicker(
      context: context,
      currentTime: selectedDate ?? DateTime.now(),
      onConfirm: (date) {
        if (date != selectedDate) {
          setState(() {
            selectedDate = date;
            dateTimeCon.text = formatDateTime(date);
          });
        }
      },
    );
  }

  void onCheckButtonTap() {
    final taskTypeId = selectedTaskType.id;
    final taskName = taskNameCon.text;
    final description = detailCon.text;

    final Task task = Task(
        id: "0",
        name: taskName,
        description: description,
        isComplete: false,
        deadline:
            (selectedDate == null) ? null : Timestamp.fromDate(selectedDate!));
    taskService.addTasks(task, taskTypeId);
  }
}
