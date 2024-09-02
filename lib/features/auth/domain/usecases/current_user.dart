import 'package:blog_nest/core/error/failures.dart';
import 'package:blog_nest/core/usecase/usecase.dart';
import 'package:blog_nest/core/common/entities/user.dart';
import 'package:blog_nest/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
   return await authRepository.currentUser();
  }

}