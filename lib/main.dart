import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/models/task.dart';
import 'package:todo/data/services/task_services.dart';
import 'package:todo/logic/cubit/task_cubit.dart';
import 'package:todo/presentation/screen/task_list_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskCubit(TaskService())..fetchTasks(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        home: TaskListScreen(),
      ),
    ),
  );
}
