import 'dart:io';
import 'package:blog_nest/core/error/exceptions.dart';
import 'package:blog_nest/core/error/failures.dart';
import 'package:blog_nest/core/network/connection_checker.dart';
import 'package:blog_nest/features/blog/data/data_sources/blog_local_data_source.dart';
import 'package:blog_nest/features/blog/data/data_sources/blog_remote_data_sources.dart';
import 'package:blog_nest/features/blog/data/models/blog_model.dart';
import 'package:blog_nest/features/blog/domain/entities/blog.dart';
import 'package:blog_nest/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogLocalDataSource _blogLocalDataSource;
  final ConnectionChecker _connectionChecker;
  final BlogRemoteDataSources _blogRemoteDataSources;

  BlogRepositoryImpl(this._blogLocalDataSource, this._connectionChecker,  {required BlogRemoteDataSources blogRemoteDataSources})
      : _blogRemoteDataSources = blogRemoteDataSources;
  @override
  Future<Either<Failure, BlogModel>> uploadBlog(
      {required File file,
      required String title,
      required String content,
      required String posterId,
      required List<String> topics}) async {
    try {
      if(!await _connectionChecker.isConnected){
        return left(Failure(message: 'Internet is not connected'));
      }
      BlogModel blogModel = BlogModel(
          id: const Uuid().v1(),
          posterId: posterId,
          title: title,
          content: content,
          imageUrl: '',
          topics: topics,
          updatedAt: DateTime.now());
      final imageUrl = await _blogRemoteDataSources.uploadBlogImage(
          file: file, blog: blogModel);
      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final uploadedBlog = await _blogRemoteDataSources.uploadBlog(blogModel);
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if(!await _connectionChecker.isConnected){
       final blogs = _blogLocalDataSource.loadBlogs();
       return right(blogs);
      }
      final blogs = await _blogRemoteDataSources.getAllBlogs();
      _blogLocalDataSource.uploadLocalBlogs(blogs: blogs);
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
