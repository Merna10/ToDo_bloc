import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/logic/cubit/task_cubit.dart';
import '../../data/models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final formattedDeadline =
        DateFormat('yyyy-MM-dd HH:mm').format(task.deadline);

    Color itemColor = Colors.white; // Default color

    if (task.deadline.isBefore(DateTime.now()) && !task.isCompleted) {
      itemColor = Colors.red;
    } else if (task.isCompleted) {
      itemColor = Colors.green;
    }

    return Dismissible(
      key: Key(task.id),
      background: Container(color: Colors.red),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<TaskCubit>(context, listen: false).deleteTask(task.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${task.title} deleted')),
        );
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete Task'),
              content: const Text('Are you sure you want to delete this task?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        );
      },
      child: Card(
        color: itemColor,
        child: ListTile(
          title: Text(
            task.title,
            style: GoogleFonts.acme(
              textStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          subtitle: Text(
            formattedDeadline,
            style: GoogleFonts.acme(
              textStyle: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          trailing: Checkbox(
            value: task.isCompleted,
            onChanged: (newValue) {
              Task updatedTask = task.copyWith(isCompleted: newValue);
              Provider.of<TaskCubit>(context, listen: false)
                  .updateTask(updatedTask);
            },
          ),
        ),
      ),
    );
  }
}
