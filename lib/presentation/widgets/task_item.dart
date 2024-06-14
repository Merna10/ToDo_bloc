import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/logic/cubit/task_cubit.dart';
import '../../data/models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final formattedDeadline = DateFormat('yyyy-MM-dd HH:mm').format(task.deadline);

    Color itemColor = Colors.white; // Default color

    if (task.deadline.isBefore(DateTime.now()) && !task.isCompleted) {
      itemColor = Colors.red; // Deadline is over and task is not completed, set color to red
    } else if (task.isCompleted) {
      itemColor = Colors.green; // Task is completed, set color to green
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
        color: itemColor, // Set the color of the card based on itemColor
        child: ListTile(
          title: Text(task.title),
          subtitle: Text(formattedDeadline),
          trailing: Checkbox(
            value: task.isCompleted,
            onChanged: (newValue) {
              // Update the task state in Hive
              Task updatedTask = task.copyWith(isCompleted: newValue);
              Provider.of<TaskCubit>(context, listen: false).updateTask(updatedTask);
            },
          ),
        ),
      ),
    );
  }
}
