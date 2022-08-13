import 'package:flutter/material.dart';
import 'package:bloc_infinite_list/posts/view/view.dart';

class App extends MaterialApp {
  const App({super.key}) : super(home: const PostsPage());
}
