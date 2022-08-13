// We need to define what our PostBloc is going to be doing...
//
// At a high level,
// - it will be responding to user input (scrolling)
// - fetching more posts in order for the presentation layer to display them
//
// Our PostBloc will only be responding to a single event PostFetched
// which will be added by the presentation layer whenever it needs more
// Posts to present.
//
// PostBloc will be receiving PostEvents and converting them to PostStates.
part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// PostFetched event is a type of PostEvent
class PostFetched extends PostEvent {}
