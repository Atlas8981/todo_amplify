/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, file_names, unnecessary_new, prefer_if_null_operators, prefer_const_constructors, slash_for_doc_comments, annotate_overrides, non_constant_identifier_names, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, unnecessary_const, dead_code

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Task type in your schema. */
@immutable
class Task extends Model {
  static const classType = const _TaskModelType();
  final String id;
  final String? _name;
  final String? _description;
  final TemporalDateTime? _dateTime;
  final bool? _isComplete;
  final int? _order;
  final String? _tasktypeID;
  final List<SubTask>? _subTasks;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get name {
    return _name;
  }
  
  String? get description {
    return _description;
  }
  
  TemporalDateTime? get dateTime {
    return _dateTime;
  }
  
  bool? get isComplete {
    return _isComplete;
  }
  
  int? get order {
    return _order;
  }
  
  String get tasktypeID {
    try {
      return _tasktypeID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<SubTask>? get subTasks {
    return _subTasks;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Task._internal({required this.id, name, description, dateTime, isComplete, order, required tasktypeID, subTasks, createdAt, updatedAt}): _name = name, _description = description, _dateTime = dateTime, _isComplete = isComplete, _order = order, _tasktypeID = tasktypeID, _subTasks = subTasks, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Task({String? id, String? name, String? description, TemporalDateTime? dateTime, bool? isComplete, int? order, required String tasktypeID, List<SubTask>? subTasks}) {
    return Task._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      description: description,
      dateTime: dateTime,
      isComplete: isComplete,
      order: order,
      tasktypeID: tasktypeID,
      subTasks: subTasks != null ? List<SubTask>.unmodifiable(subTasks) : subTasks);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Task &&
      id == other.id &&
      _name == other._name &&
      _description == other._description &&
      _dateTime == other._dateTime &&
      _isComplete == other._isComplete &&
      _order == other._order &&
      _tasktypeID == other._tasktypeID &&
      DeepCollectionEquality().equals(_subTasks, other._subTasks);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Task {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("dateTime=" + (_dateTime != null ? _dateTime!.format() : "null") + ", ");
    buffer.write("isComplete=" + (_isComplete != null ? _isComplete!.toString() : "null") + ", ");
    buffer.write("order=" + (_order != null ? _order!.toString() : "null") + ", ");
    buffer.write("tasktypeID=" + "$_tasktypeID" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Task copyWith({String? id, String? name, String? description, TemporalDateTime? dateTime, bool? isComplete, int? order, String? tasktypeID, List<SubTask>? subTasks}) {
    return Task._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      isComplete: isComplete ?? this.isComplete,
      order: order ?? this.order,
      tasktypeID: tasktypeID ?? this.tasktypeID,
      subTasks: subTasks ?? this.subTasks);
  }
  
  Task.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _description = json['description'],
      _dateTime = json['dateTime'] != null ? TemporalDateTime.fromString(json['dateTime']) : null,
      _isComplete = json['isComplete'],
      _order = (json['order'] as num?)?.toInt(),
      _tasktypeID = json['tasktypeID'],
      _subTasks = json['subTasks'] is List
        ? (json['subTasks'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => SubTask.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'description': _description, 'dateTime': _dateTime?.format(), 'isComplete': _isComplete, 'order': _order, 'tasktypeID': _tasktypeID, 'subTasks': _subTasks?.map((SubTask? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "task.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField DATETIME = QueryField(fieldName: "dateTime");
  static final QueryField ISCOMPLETE = QueryField(fieldName: "isComplete");
  static final QueryField ORDER = QueryField(fieldName: "order");
  static final QueryField TASKTYPEID = QueryField(fieldName: "tasktypeID");
  static final QueryField SUBTASKS = QueryField(
    fieldName: "subTasks",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (SubTask).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Task";
    modelSchemaDefinition.pluralName = "Tasks";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.DATETIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.ISCOMPLETE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.ORDER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.TASKTYPEID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Task.SUBTASKS,
      isRequired: false,
      ofModelName: (SubTask).toString(),
      associatedKey: SubTask.TASKID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _TaskModelType extends ModelType<Task> {
  const _TaskModelType();
  
  @override
  Task fromJson(Map<String, dynamic> jsonData) {
    return Task.fromJson(jsonData);
  }
}