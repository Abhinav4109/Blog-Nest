import 'dart:io';

import 'package:blog_nest/core/usecase/usecase.dart';
import 'package:blog_nest/features/blog/domain/entities/blog.dart';
import 'package:blog_nest/features/blog/domain/usecases/get_blog.dart';
import 'package:blog_nest/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getBlog;
  BlogBloc(this._uploadBlog, this._getBlog) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoading());
    });
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAll>(_onBlogFetchAll);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(UploadBlogParams(
        file: event.file,
        title: event.title,
        content: event.content,
        posterId: event.posterId,
        topics: event.topics));
    res.fold((failure) => emit(BlogFailure(error: failure.message)),
        (_) => emit(BlogUploadSuccess()));
  }

  void _onBlogFetchAll(BlogFetchAll event, Emitter<BlogState> emit) async{
    final res = await _getBlog(NoParams());
    res.fold((failure) => emit(BlogFailure(error: failure.message)), (blogs) => emit(BlogFetchSucess(blogs: blogs)));
  }
}
