import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/services/task_services.dart';
import 'package:todo/logic/cubit/task_cubit.dart';
import 'package:todo/presentation/screen/task_list_screen.dart';

class TaskProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskService = TaskService();
    final taskCubit = TaskCubit(taskService);

    return BlocProvider(
      create: (context) => taskCubit,
      child: MaterialApp(
        title: 'Your App',
        home: TaskListScreen(),
      ),
    );
  }
}
