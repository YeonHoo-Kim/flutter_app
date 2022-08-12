// Our TimerBloc state can be one of the following:
// - TimerInitial - ready to start counting down fron the specified duration
// - TimreRunInProgress - actively counting down fron the specified duration
// - TimerRunPause - paused at some remaining duration
// - TimerRunComplete - completed with a remaining duration of 0
//
// Each of these states will have an implication on the user interface and
// actions that the user can perform.
//
// If the state is ...
// - TimerInitial: the user will be able to start the timer.
// - TimerRunInProgress: the user will be able to pause and reset the timer
//                       as well as see the remaining duration.
// - TimerRunPause: the user will be able to resume the timer and reset the timer.
// - TimerRunComplete: the user will be able to reset the timer

part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final int duration;
  const TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

class TimerInitial extends TimerState {
  const TimerInitial(super.duration);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

class TimerRunPause extends TimerState {
  const TimerRunPause(super.duration);

  @override
  String toString() => 'TimerRunPause { duration: $duration }';
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(super.duration);

  @override
  String toString() => 'TimerRunInProgress { duration: $duration }';
}

class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0);
}

// Note that all of the TimerStates extend the abstract base class
// TimerState which has a duration property.
// This is because no matter what state our TimerBloc is in, 
// we want to know how much time is remaining.
// Additionally, TimerState extends Equatable to optimize our code by
// ensuring that our app does not trigger rebuilds if the same state occurs.
