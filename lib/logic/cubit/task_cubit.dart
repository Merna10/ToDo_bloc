import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/data/models/task.dart';
import 'package:todo/data/services/task_services.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskService _taskService;

  TaskCubit(this._taskService) : super(TaskInitial());

  void fetchTasks() {
    final tasks = _taskService.getTasks();
    emit(TaskLoaded(tasks));
  }

  void addTask(Task task) {
    _taskService.addTask(task);
    fetchTasks();
  }

  void updateTask(Task task) {
    task.isCompleted = !task.isCompleted; // Toggle the completion status
    _taskService.updateTask(task);
    fetchTasks();
  }

  void deleteTask(String id) {
    print('Deleting task with ID: $id');
    _taskService.deleteTask(id); // Delete the task from storage
    final updatedTasks = _taskService.getTasks(); // Fetch the updated task list

    // Update the state only if the task was successfully deleted
    final isDeleted = updatedTasks.where((task) => task.id == id).isEmpty;
    if (isDeleted) {
      emit(TaskLoaded(updatedTasks)); // Emit a new state with the updated list
    } else {
      print(
          'Failed to delete task with ID: $id'); // Print an error message if deletion failed
    }
  }
}
