import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController controller = TextEditingController();

  List<Map<String, dynamic>> tasks = [];

  void addTask() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      tasks.insert(0, {"title": controller.text, "done": false});
    });

    controller.clear();
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index]["done"] = !tasks[index]["done"];
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "To Do App",
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 12,
        shadowColor: Colors.amber,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Expanded(
            child: tasks.isEmpty
                ? const Center(
                    child: Text("No Tasks Yet", style: TextStyle(color: Colors.amber , fontSize: 22)),
                  )
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            fillColor: WidgetStateProperty.all(Colors.amber),
                            value: tasks[index]["done"],
                            onChanged: (_) {
                              toggleTask(index);
                            },
                          ),
                          title: Text(
                            tasks[index]["title"],
                            style: TextStyle(
                              decoration: tasks[index]["done"]
                                  ? TextDecoration.lineThrough
                                  : null,
                              decorationColor: Colors.yellow,
                              decorationThickness: 2,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.amber),
                            onPressed: () {
                              deleteTask(index);
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 32,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: const TextStyle(fontSize: 16.0),
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "Enter Task",
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 109, 83, 2),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber), // Idle color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.amberAccent,
                    ), // Focus color
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.amber, // Change this to your preferred color
              ),

              onPressed: addTask,
              child: const Text("Add", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
