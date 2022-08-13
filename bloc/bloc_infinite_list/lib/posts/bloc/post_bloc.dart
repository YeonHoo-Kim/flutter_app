import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:bloc_infinite_list/posts/models/post.dart';

part 'post_event.dart';
part 'post_state.dart';

const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return ((events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  });
}

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({required this.httpClient}) : super(const PostState()) {
    on<PostFetched>(
      _onPostFetched,
      // Passing a transformer to on<PostFetched> allows us to customize how events are processed
      transformer: throttleDroppable(throttleDuration),
    );
  }

  // We need to register an event handler to handle incoming PostFetched events.
  // In response to a PostFetched event, we will call _fetchPosts to fetch posts from the API
  Future<void> _onPostFetched(
    PostFetched event,
    Emitter<PostState> emit,
  ) async {
    // PostBloc will emit new states wia the Emitter<PostState> provided in the event handler
    // Now every time a PostEvent is added, if it is a PostFetched event and there are more posts to fetch,
    // our PostBloc will fetch the next 20 posts
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        // If we can retrieve the posts, we return PostSuccess()
        // which takes the entire list of posts
        return emit(state.copyWith(
          status: PostStatus.success,
          posts: posts,
          hasReachedMax: false,
        ));
      }
      // The API will return an empty array if we try to fetch beyond the maximum
      // number of posts (100), so if we get back an empty array, our bloc will emit
      // the currentState except we will set hasReachedMax to true
      final posts = await _fetchPosts(state.posts.length);
      // PostSuccess()
      emit(posts.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: PostStatus.success,
              posts: List.of(state.posts)..addAll(posts),
              hasReachedMax: false,
            ));
    } catch (_) {
      // If we cannot retrieve the posts, we throw an exception and emit PostFailure()
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<List<Post>> _fetchPosts([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'},
      ),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Post(
          id: map['id'] as int,
          title: map['title'] as String,
          body: map['body'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}

// One optimization we can make is to debounce the Events in order to
// prevent spamming our API unnecessarily. We can do this by overriding the
// transform method in our PostBloc...
