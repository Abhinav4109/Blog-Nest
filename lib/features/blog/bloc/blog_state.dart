part of 'blog_bloc.dart';
@immutable
sealed class BlogState{}

class BlogInitial extends BlogState{}

class BlogLoading extends BlogState{}

class BlogFailure extends BlogState{
  final String error;

  BlogFailure({required this.error});
}

class BlogUploadSuccess extends BlogState{}

class BlogFetchSucess extends BlogState{
  final List<Blog> blogs;

  BlogFetchSucess({required this.blogs});
}