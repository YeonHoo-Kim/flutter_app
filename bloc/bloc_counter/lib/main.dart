import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc_counter/app.dart';
import 'package:bloc_counter/counter_observer.dart';

void main() {
  Bloc.observer = CounterObserver();
  runApp(const CounterApp());
}

// We are initializing the CounterObserver we just created 
// and calling runApp with the CounterApp Widget