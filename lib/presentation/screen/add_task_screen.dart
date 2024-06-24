import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        backgroundColor: const Color.fromARGB(255, 248, 182, 124),
        title: Text(
          'Add Task',
          style: GoogleFonts.acme(
            textStyle: const TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 248, 182, 124),
                  Color.fromARGB(255, 255, 218, 185),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: GoogleFonts.acme(
                        textStyle:
                            const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                  TextField(
                    controller: _deadlineController,
                    decoration: InputDecoration(
                      labelText: 'Deadline (yyyy-MM-dd HH:mm)',
                      labelStyle: GoogleFonts.acme(
                        textStyle:
                            const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
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
                              DateFormat('yyyy-MM-dd HH:mm')
                                  .format(fullDateTime);
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final task = Task(
                        id: const Uuid().v4(), // Generate unique ID
                        title: _titleController.text,
                        deadline: DateTime.parse(_deadlineController.text),
                        isCompleted: false,
                      );
                      Provider.of<TaskCubit>(context, listen: false)
                          .addTask(task);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 248, 182, 124),
                      minimumSize:
                          const Size(0, 50), // Set the desired height here
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.acme(
                        textStyle: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
