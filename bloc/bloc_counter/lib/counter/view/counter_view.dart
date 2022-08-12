import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_counter/counter/counter.dart';

class CounterView extends StatelessWidget {
  // CounterView is responsible for rendering the current count and
  // rendering two FloatingActionButtons to increment/decrement the counter
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Bloc Counter')),
      body: Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            return Text('$state', style: textTheme.headline2);
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            key: const Key('counterView_increment_floatingActionButton'),
            child: const Icon(Icons.add),
            onPressed: () {
              context.read<CounterCubit>().increment();
            },
          ),
          FloatingActionButton(
            key: const Key('counterView_decrement_floatingActionButton'),
            child: const Icon(Icons.remove),
            onPressed: () {
              context.read<CounterCubit>().decrement();
            },
          )
        ],
      ),
    );
  }
}

// A BlocBuilder is used to wrap the Text widget in order to update the text
// any time the CounterCubit state changes.
// In addition, context.read<CounterCubit>() is used 
// to look-up the closest CounterCubit instance.

// Only the Text widget is wrapped in a BlocBuilder because that is the only
// widget that needs to be rebuilt in response to state changes in the CounterCubit.
// Avoid unnecessarily wrapping widgets that don't need to be rebuilt
// when a state changes.