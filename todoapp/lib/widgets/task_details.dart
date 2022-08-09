import 'package:flutter/material.dart';
import 'package:todoapp/database/database.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/widgets/task_check.dart';

class TaskDetails extends StatefulWidget {
  final Task? task;

  const TaskDetails({Key? key, this.task}) : super(key: key);

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  DatabaseHelper dbHelper = DatabaseHelper();

  int? taskId = 0;
  String? taskTitle = "";
  String? taskDescription = "";

  late FocusNode titleFocus;
  late FocusNode descriptionFocus;
  late FocusNode todoFocus;

  bool contentVisible = false;

  @override
  void initState() {
    if (widget.task != null) {
      contentVisible = true;
      taskTitle = widget.task!.title;
      taskDescription = widget.task!.description ?? "";
      taskId = widget.task!.id;
    }
    titleFocus = FocusNode();
    descriptionFocus = FocusNode();
    todoFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    titleFocus.dispose();
    descriptionFocus.dispose();
    todoFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24,
                      bottom: 6,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(24),
                            child: Image(
                              image: AssetImage(
                                  'assets/images/back_arrow_icon.png'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: titleFocus,
                            onSubmitted: (value) async {
                              // check if the field is not empty
                              if (value != "") {
                                if (widget.task == null) {
                                  Task newTask = Task(title: value);
                                  int newTaskId =
                                      await dbHelper.insertTask(newTask);
                                  debugPrint('new task created Id: $newTaskId');
                                  setState(() {
                                    contentVisible = true;
                                    taskId = newTaskId;
                                    taskTitle = value;
                                  });
                                } else {
                                  debugPrint('update the existing task');
                                  await dbHelper.updateTaskTitle(
                                      taskId!, value);
                                  debugPrint('Task title Updated');
                                  setState(() {
                                    taskTitle = value;
                                  });
                                }
                                descriptionFocus.requestFocus();
                              }
                            },
                            controller: TextEditingController()
                              ..text = taskTitle!,
                            decoration: const InputDecoration(
                              hintText: "Enter Task Title",
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF211551),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: contentVisible,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TextField(
                        focusNode: descriptionFocus,
                        onSubmitted: (value) async {
                          if (value != "" && taskId != 0) {
                            await dbHelper.updateTaskDescription(
                                taskId!, value);
                            taskDescription = value;
                          }
                          todoFocus.requestFocus();
                        },
                        controller: TextEditingController()
                          ..text = taskDescription!,
                        decoration: const InputDecoration(
                          hintText: "Enter Description for the task...",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: contentVisible,
                    child: FutureBuilder<List<Todo>>(
                      initialData: const [],
                      future: dbHelper.getTodos(taskId!),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            child: const Text('Loading...'),
                          );
                        }
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  // Switch the todo completion state
                                  if (snapshot.data![index].isDone == 0) {
                                    await dbHelper.updateTodoDone(
                                        snapshot.data![index].id!, 1);
                                  } else {
                                    await dbHelper.updateTodoDone(
                                        snapshot.data![index].id!, 0);
                                  }
                                  setState(() {});
                                },
                                child: TaskCheck(
                                  text: snapshot.data![index].title,
                                  isDone: snapshot.data![index].isDone == 0
                                      ? false
                                      : true,
                                ),
                              );
                            }),
                          ),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: contentVisible,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.transparent,
                              border: Border.all(
                                color: const Color(0xFF868290),
                                width: 1.5,
                              ),
                            ),
                            child: const Image(
                              image: AssetImage('assets/images/check_icon.png'),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              focusNode: todoFocus,
                              controller: TextEditingController()..text = "",
                              onSubmitted: (value) async {
                                // check if the field is not empty
                                if (value != "") {
                                  if (taskId != 0) {
                                    DatabaseHelper dbHelper = DatabaseHelper();
                                    Todo newTodo = Todo(
                                      taskId: taskId!,
                                      title: value,
                                      isDone: 0,
                                    );
                                    await dbHelper.insertTodo(newTodo);
                                    setState(() {});
                                    todoFocus.requestFocus();
                                  }
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter Todo item...',
                                border: InputBorder.none,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: contentVisible,
                child: Positioned(
                  bottom: 24,
                  right: 24,
                  child: GestureDetector(
                    onTap: () async {
                      if (taskId != 0) {
                        await dbHelper.deleteTask(taskId!);
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xFFFE3572),
                      ),
                      child: const Image(
                        image: AssetImage('assets/images/delete_icon.png'),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
