import 'dart:io';

import 'package:blog_nest/core/error/failures.dart';
import 'package:blog_nest/core/usecase/usecase.dart';
import 'package:blog_nest/features/blog/domain/entities/blog.dart';
import 'package:blog_nest/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository _blogRepository;

  UploadBlog({required BlogRepository blogRepository})
      : _blogRepository = blogRepository;
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await _blogRepository.uploadBlog(
        file: params.file,
        title: params.title,
        content: params.content,
        posterId: params.posterId,
        topics: params.topics);
  }
}

class UploadBlogParams {
  final File file;
  final String title;
  final String content;
  final String posterId;
  final List<String> topics;

  UploadBlogParams(
      {required this.file,
      required this.title,
      required this.content,
      required this.posterId,
      required this.topics});
}
