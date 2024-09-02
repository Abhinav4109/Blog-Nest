import 'package:blog_nest/core/error/failures.dart';
import 'package:blog_nest/core/usecase/usecase.dart';
import 'package:blog_nest/features/blog/domain/entities/blog.dart';
import 'package:blog_nest/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository _blogRepository;

  GetAllBlogs({required BlogRepository blogRepository})
      : _blogRepository = blogRepository;

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await _blogRepository.getAllBlogs();
  }
}
