import 'package:blog_nest/core/error/failures.dart';
import 'package:blog_nest/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required name,
    required email,
    required password,
  });
  Future<Either<Failure, User>> loginWithEmailPassword({
    required email,
    required password,
  });

  Future<Either<Failure, User>> currentUser();
}
