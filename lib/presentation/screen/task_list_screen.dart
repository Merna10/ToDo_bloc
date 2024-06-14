import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/logic/cubit/task_cubit.dart';
import 'package:todo/presentation/screen/add_task_screen.dart';
import '../widgets/task_item.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskCubit = context.read<TaskCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddTaskScreen()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoaded) {
            final tasks = state.tasks;
            final completedTasks = tasks.where((task) => task.isCompleted).toList();
            AssetImage imageToShow = completedTasks.length == tasks.length
                ? const AssetImage('assets/images/finish.jpg')
                : completedTasks.isNotEmpty
                    ? const AssetImage('assets/images/can.jpg')
                    : const AssetImage('assets/images/start.jpg');
            return Column(
              children: [
                Container(
                  height: 230,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageToShow,
                      fit: BoxFit.cover,
                    ),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Completed Tasks: ${completedTasks.length} / ${tasks.length}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 22,
                          backgroundColor: Color.fromARGB(109, 192, 189, 180),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: tasks.isEmpty
                      ? const Center(child: Text('No tasks available'))
                      : ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            final task = tasks[index];
                            return TaskItem(task: task);
                          },
                        ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
