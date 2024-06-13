import 'package:hive/hive.dart';
import 'package:todo/data/models/task.dart';

class TaskService {
  final Box<Task> _taskBox =
      Hive.box<Task>('tasks'); // Assuming 'tasks' is the name of your Hive box

  List<Task> getTasks() {
    return _taskBox.values.toList(); // Return tasks from Hive box
  }

  void addTask(Task task) {
    _taskBox.add(task); // Save task to Hive box
  }

  void updateTask(Task updatedTask) {
    final index = _taskBox.keys.toList().indexOf(updatedTask.id);
    if (index != -1) {
      _taskBox.putAt(index, updatedTask); // Update task in Hive box
    }
  }

  void deleteTask(String id) {
    print(
        'Deleting task from storage with ID: $id'); // Add a print statement here

    _taskBox.delete(id);
  }
}
