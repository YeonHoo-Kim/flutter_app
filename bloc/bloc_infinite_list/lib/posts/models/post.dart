import 'package:equatable/equatable.dart';

class Post extends Equatable {
  // model of post object
  final int id;
  final String title;
  final String body;

  const Post({required this.id, required this.title, required this.body});

  @override
  List<Object> get props => [id, title, body];

  // Extending Equatable means that we can compare Posts.
  // Without this, we would need to manually change our class to override
  // equality and hashCode so that we could tell the difference between
  // two Posts objects

  // 즉, Equatable은 Post 클래스의 두 인스턴스를 비교할 수 있게 해준다.
}
