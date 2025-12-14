part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

class CreateBlogEvent extends BlogEvent {
  final BlogRequest blogRequest;

  CreateBlogEvent(this.blogRequest);
}
