import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/logic/cubit/task_cubit.dart';
import 'package:todo/presentation/screen/add_task_screen.dart';
import '../widgets/task_item.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskCubit = context.read<TaskCubit>();

    return Scaffold(
      body: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 255, 254, 254),
                Color.fromARGB(255, 248, 182, 124),
                Color.fromARGB(255, 255, 213, 176),
                Color.fromARGB(255, 255, 254, 254),
              ],
            ),
          ),
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              if (state is TaskLoaded) {
                final tasks = state.tasks;
                final completedTasks =
                    tasks.where((task) => task.isCompleted).toList();
                // AssetImage imageToShow = completedTasks.length == tasks.length
                //     ? const AssetImage('assets/images/finish.jpg')
                //     : completedTasks.isNotEmpty
                //         ? const AssetImage('assets/images/can.jpg')
                //         : const AssetImage('assets/images/start.jpg');
                return Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.15,
                        ),
                        Text(
                          'Completed Tasks: ${completedTasks.length} / ${tasks.length}',
                          style: GoogleFonts.acme(
                            textStyle: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
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
        ),
      ),
    );
  }
}
