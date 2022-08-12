import 'package:flutter/material.dart';
import 'package:bloc_counter/counter/counter.dart';

class CounterApp extends MaterialApp {
  // CounteApp will be a MaterialApp and is specifying the home as CounterPage
  const CounterApp({super.key}) : super(home: const CounterPage());
}

// We are extending MaterialApp because CounterApp is a MaterialApp
// In most cases, we're going to be creating StatelessWidget or StatefulWidget
// instances and composing widgets in build
// but in this case there are no widgets to compose 
// so it's simpler to just extend MaterialApp...