// Our TimerBloc will need to know how to process these events.
//
// TimerStarted - informs the TimerBloc that the timer should be started
// TimerPaused - informs the TimerBloc that the timer should be paused
// TimerResumed - informs the TimerBloc that the timer should be resumed
// TimerReset - informs the TimerBloc that the timer should be reset to the original state
// TimerTicked - informs the TimerBloc that the tick has occurred
//               and that it needs to update its state accordingly.

part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStarted extends TimerEvent {
  final int duration;
  const TimerStarted({required this.duration});
}

class TimerPaused extends TimerEvent {
  const TimerPaused();
}

class TimerResumed extends TimerEvent {
  const TimerResumed();
}

class TimerReset extends TimerEvent {
  const TimerReset();
}

class TimerTicked extends TimerEvent {
  final int duration;
  const TimerTicked({required this.duration});

  @override
  List<Object> get props => [duration];
}
