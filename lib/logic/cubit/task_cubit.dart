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
    _taskService.updateTask(task);
    fetchTasks();
  }

  void deleteTask(String id) {
    print('Deleting task with ID: $id');
    final deleted = _taskService.deleteTask(id);

    if (deleted) {
      print('Task deleted successfully.');
      fetchTasks(); // Update tasks after deletion
    } else {
      print('Failed to delete task with ID: $id');
    }
  }
}
