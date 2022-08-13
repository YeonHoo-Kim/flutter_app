import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:bloc_infinite_list/posts/bloc/post_bloc.dart';

import 'posts_list.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      // In our PostsPage widget we use BlocProvider to create and provide an
      // instance of PostBloc to the subtree. Also, we add a PostFetched event
      // so that when the app loads, it requests the initial batch of Posts.
      body: BlocProvider(
        create: (_) => PostBloc(httpClient: http.Client())..add(PostFetched()),
        child: const PostsList(),
      ),
    );
  }
}
