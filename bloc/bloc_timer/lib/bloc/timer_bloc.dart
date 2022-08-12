import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_timer/ticker.dart';
import 'package:equatable/equatable.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int _duration = 60; // 1. Define a initial state
  final Ticker _ticker; // 2. Define a dependency on our Ticker

  // 2-1. Defining a StreamSubscription for our Ticker
  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(TimerInitial(_duration)) {
    on<TimerStarted>(_onStarted);
    on<TimerTicked>(_onTicked);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerReset>(_onReset);
  }

  // 3-1. We need to override the close method on our TimerBloc
  // so that we can cancel the _tickerSubscription when the TimerBloc is closed
  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  // 3. implement the event handlers(TimerStarted).
  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.tick(ticks: event.duration).listen((duration) {
      return add(TimerTicked(duration: duration));
    });

    // If the TimerBloc receives a TimerStarted event,
    // it pushes a TimerRunInProgress state with the start duration.
    // In addition, if there was already an open _tickerSubscription
    // we need to cancel it to deallocate the memory.
  }

  // 4. implement TimerTicked event handler
  // We listen to the _ticker.tick stream and on every tick
  // we add a TimerTicked event with the remaining duration.
  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(
      event.duration > 0
          ? TimerRunInProgress(event.duration)
          : TimerRunComplete(),
    );

    // Every time a TimerTicked event is received,
    // if tick's duration > 0
    //   we need to push an updated TimerRunInProgress state with the new duration.
    // else (tick's duration = 0)
    //   our timer has ended and we need to push a TimerRunComplete state.
  }

  // 5. implement TimerPaused event handler
  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(state.duration));
    }

    // If the state of our TimerBloc is TimerRunInProgress
    //   we can pause the _tickerSubscription
    //   and push a TimerRunPause state with the current timer duration
  }

  // 6. implement TimerResumed event handler
  void _onResumed(TimerResumed event, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }

    // If the TimerBloc has a state of TimerRunPause and it receives a TimerResumed event
    //  it resumes the _tickerSubscription
    //  and pushes a TimerRunInProgress state with the current duration.
  }

  // 7. implement TimerReset event handler
  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(const TimerInitial(_duration));
  }

  // If the TimerBloc receives a TimerReset event
  // it needs to cancel the current _tickerSubscription
  // so that it isn't notified of any additional ticks
  // and pushes a TimerInitial state with the original duration
}
