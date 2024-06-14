import 'package:hive/hive.dart';
import 'package:todo/data/models/task.dart';

class TaskService {
  final Box<Task> _taskBox = Hive.box<Task>('tasks');

  List<Task> getTasks() {
    return _taskBox.values.toList();
  }

  void addTask(Task task) {
    _taskBox.add(task);
  }

  void updateTask(Task updatedTask) {
    try {
      final taskKey = _taskBox.keys.firstWhere((key) {
        final task = _taskBox.get(key);
        return task?.id == updatedTask.id;
      });

      _taskBox.put(taskKey, updatedTask);
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  bool deleteTask(String id) {
    print('Deleting task from storage with ID: $id');
    try {
      final taskKey = _taskBox.keys.firstWhere((key) {
        final task = _taskBox.get(key);
        return task?.id == id;
      });
      _taskBox.delete(taskKey);
      return true;
    } catch (e) {
      print('Error deleting task: $e');
      return false;
    }
  }
}
