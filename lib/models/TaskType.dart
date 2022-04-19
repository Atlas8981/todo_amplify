import 'package:cloud_firestore/cloud_firestore.dart';

import 'Task.dart';

class TaskType {
  final String id;
  String? name;
  List<Task>? tasks;
  final Timestamp? createdAt;
  Timestamp? updatedAt;

  TaskType({
    required this.id,
    this.name,
    this.tasks,
    this.createdAt,
    this.updatedAt,
  });

  factory TaskType.fromJson(Map<String, dynamic> json) => TaskType(
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
        name: json["name"],
        tasks:
            List<Task>.from(json["tasks"].map((x) => Task.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tasks": List<dynamic>.from(tasks?.map((x) => x.toJson())??[]),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };

  @override
  String toString() {
    return 'TaskType{id: $id, name: $name, tasks: $tasks, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
