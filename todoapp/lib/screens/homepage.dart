import 'package:flutter/material.dart';
import 'package:todoapp/database/database.dart';
import 'package:todoapp/widgets/task_card.dart';
import 'package:todoapp/widgets/task_details.dart';

import '../models/task.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          color: const Color(0xFFF6F6F6),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 32, bottom: 32),
                    child: const Image(
                      image: AssetImage(
                        'assets/images/logo.png',
                      ),
                    ),
                  ),
                  FutureBuilder<List<Task>>(
                    initialData: const [],
                    future: dbHelper.getTasks(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                          child: const Text('Loading...'),
                        );
                      }
                      return Expanded(
                        child: ScrollConfiguration(
                          behavior: NoGlowBehavior(),
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TaskDetails(
                                        task: snapshot.data![index],
                                      ),
                                    ),
                                  ).then((value) {
                                    setState(() {});
                                  });
                                  ;
                                }),
                                child: Taskcard(
                                  title: snapshot.data![index].title,
                                  description:
                                      snapshot.data![index].description,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Positioned(
                bottom: 24,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TaskDetails(),
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF7349FE),
                          const Color(0xFF643FDB),
                        ],
                        begin: Alignment(0, -1),
                        end: Alignment(0, 1),
                      ),
                    ),
                    child: const Image(
                      image: AssetImage('assets/images/add_icon.png'),
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

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportchrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
