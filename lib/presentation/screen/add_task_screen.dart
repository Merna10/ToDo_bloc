import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:todo/logic/cubit/task_cubit.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/task.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _deadlineController,
              decoration: const InputDecoration(
                  labelText: 'Deadline (yyyy-MM-dd HH:mm)'),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null) {
                  TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    final DateTime fullDateTime = DateTime(
                      picked.year,
                      picked.month,
                      picked.day,
                      time.hour,
                      time.minute,
                    );
                    _deadlineController.text =
                        DateFormat('yyyy-MM-dd HH:mm').format(fullDateTime);
                  }
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                final task = Task(
                  id: const Uuid().v4(), // Generate unique ID
                  title: _titleController.text,
                  deadline: DateTime.parse(_deadlineController.text),
                  isCompleted: false,
                );
                Provider.of<TaskCubit>(context, listen: false).addTask(task);
                Navigator.of(context).pop();
              },
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
