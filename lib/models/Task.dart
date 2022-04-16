import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_amplify/models/SubTask.dart';


class Task {
  final String id;
  final String? name;
  final String? description;
  final Timestamp? deadline;
  final bool? isComplete;
  final int? order;
  final List<SubTask>? subTasks;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  Task({
    required this.id,
    this.name,
    this.description,
    this.deadline,
    this.isComplete,
    this.order,
    this.subTasks,
    this.createdAt,
    this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        createdAt: (json["createdAt"] is int)
            ? Timestamp.fromDate(
                DateTime.fromMillisecondsSinceEpoch(json["createdAt"]),
              )
            : json["createdAt"],
        updatedAt: (json["updatedAt"] is int)
            ? Timestamp.fromDate(
                DateTime.fromMillisecondsSinceEpoch(json["updatedAt"]),
              )
            : json["updatedAt"],
        deadline: (json["deadline"] is int)
            ? Timestamp.fromDate(
                DateTime.fromMillisecondsSinceEpoch(json["deadline"]),
              )
            : json["deadline"],
        name: json["name"],
        subTasks:
            List<SubTask>.from(json["SubTask"].map((x) => SubTask.fromJson(x))),
        isComplete: json["isComplete"],
        order: json["order"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "deadline": deadline,
        "subTasks": List<SubTask>.from(subTasks?.map((x) => x.toJson()) ?? []),
        "isComplete": isComplete,
        "order": order,
        "description": description,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
