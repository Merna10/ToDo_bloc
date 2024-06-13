import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/logic/cubit/task_cubit.dart';
import '../../data/models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDeadline =
        DateFormat('yyyy-MM-dd HH:mm').format(task.deadline);

    Color itemColor = Colors.white; // Default color

    if (task.deadline.isBefore(DateTime.now()) && !task.isCompleted) {
      itemColor = Colors
          .red; // Deadline is over and task is not completed, set color to red
    } else if (task.isCompleted) {
      itemColor = Colors.green; // Task is completed, set color to green
    }

    return Card(
      color: itemColor, // Set the color of the card based on itemColor
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Delete Task'),
                content: Text('Are you sure you want to delete this task?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<TaskCubit>(context, listen: false)
                          .deleteTask(task.id);
                      Navigator.of(context).pop();
                    },
                    child: Text('Delete'),
                  ),
                ],
              );
            },
          );
        },
        child: ListTile(
          title: Text(task.title),
          subtitle: Text(formattedDeadline),
          trailing: Checkbox(
            value: task.isCompleted,
            onChanged: (newValue) {
              Provider.of<TaskCubit>(context, listen: false).updateTask(task);
            },
          ),
        ),
      ),
    );
  }
}
