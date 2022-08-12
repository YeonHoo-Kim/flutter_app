import 'package:flutter/material.dart';

import 'package:bloc_timer/widget/background.dart';

import 'timer_actions.dart';
import 'timer_text.dart';

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Bloc Timer')),
      body: Stack(
        children: [
          const Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 100,
                ),
                child: Center(child: TimerText()),
              ),
              TimerActions(),
            ],
          ),
        ],
      ),
    );
  }
}
