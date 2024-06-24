import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/presentation/screen/add_task_screen.dart';
import 'package:todo/presentation/screen/task_list_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/time.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.15,
            ),
            Text(
              "Action Agenda",
              style: GoogleFonts.acme(
                textStyle: const TextStyle(
                    fontSize: 67,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 79, 32, 172)),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddTaskScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 248, 182, 124),
                      minimumSize:
                          const Size(0, 50), // Set the desired height here
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    child: Text(
                      'Add Tasks',
                      style: GoogleFonts.acme(
                        textStyle: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TaskListScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 248, 182, 124),
                      minimumSize:
                          const Size(0, 50), // Set the desired height here
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    child: Text(
                      'See Tasks',
                      style: GoogleFonts.acme(
                        textStyle: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
