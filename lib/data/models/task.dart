import 'package:hive/hive.dart';

part 'task.g.dart'; // Generated file

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  DateTime deadline;

  @HiveField(3)
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.deadline,
    required this.isCompleted,
  });
  Task copyWith({
    String? id,
    String? title,
    DateTime? deadline,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      deadline: deadline ?? this.deadline,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
