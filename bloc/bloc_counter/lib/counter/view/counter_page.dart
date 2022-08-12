import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_counter/counter/counter.dart';

class CounterPage extends StatelessWidget {
  // The CounterPage widget is responsible for creating a CounterCubit
  // and providing it to the CounterView
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const CounterView(),
    );
  }
}

// It's important to separate or decouple the creation of a Cubit
// from the consumption of a Cubit
// in order to have code that is much more testable and reusable