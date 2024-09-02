import 'dart:io';

import 'package:blog_nest/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  BlogBloc(this._uploadBlog) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoading());
    });
    on<BlogUpload>(_onBlogUpload);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(UploadBlogParams(
        file: event.file,
        title: event.title,
        content: event.content,
        posterId: event.posterId,
        topics: event.topics));
    res.fold((failure) => emit(BlogFailure(error: failure.message)),
        (_) => emit(BlogSuccess()));
  }
}
