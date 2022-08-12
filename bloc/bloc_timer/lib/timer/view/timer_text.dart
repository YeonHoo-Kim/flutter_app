import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_timer/timer/timer.dart';

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((TimerBloc bloc) => bloc.state);
    final minStr =
        ((state.duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secStr = (state.duration % 60).floor().toString().padLeft(2, '0');

    if (state is! TimerInitial) {
      return Text(
        '$minStr:$secStr',
        style: Theme.of(context).textTheme.headline1,
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          // controller: TextEditingController()..text = ,
          // onSubmitted: (){ },
          style: Theme.of(context).textTheme.headline1,
        ),
        Text(
          ':',
          style: Theme.of(context).textTheme.headline1,
        ),
        TextField(
          // controller: TextEditingController()..text = ,
          // onSubmitted: (){ },
          style: Theme.of(context).textTheme.headline1,
        ),
      ],
    );
  }
}
