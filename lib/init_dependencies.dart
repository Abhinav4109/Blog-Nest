import 'package:blog_nest/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_nest/core/secrets/supabase_secrets.dart';
import 'package:blog_nest/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_nest/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_nest/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_nest/features/auth/domain/usecases/current_user.dart';
import 'package:blog_nest/features/auth/domain/usecases/user_signin.dart';
import 'package:blog_nest/features/auth/domain/usecases/user_signup.dart';
import 'package:blog_nest/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: SupabaseSecrets.supabaseUrl,
    anonKey: SupabaseSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth(){
  serviceLocator..registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(serviceLocator()))
  ..registerFactory<AuthRepository>(() =>  AuthRepositoryImpl(remoteDataSource: serviceLocator()))
  ..registerFactory(() => UserSignup(authRepository: serviceLocator()))
  ..registerFactory(() => UserSignin(authRepository: serviceLocator()))
  ..registerFactory(() => CurrentUser(authRepository: serviceLocator()))
  ..registerLazySingleton(() => AuthBloc(serviceLocator(), serviceLocator(), serviceLocator(), serviceLocator()));
}
