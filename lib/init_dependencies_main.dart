part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: SupabaseSecrets.supabaseUrl,
    anonKey: SupabaseSecrets.supabaseAnonKey,
  );

      final appDocumentDir = await getApplicationDocumentsDirectory();
    
    // Initialize Hive with the documents directory path
    Hive.init(appDocumentDir.path);
  final blogsBox = await Hive.openBox('blogs');
    serviceLocator.registerLazySingleton(
    () => blogsBox);

  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory(() => InternetConnectionChecker());
  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(connectionChecker: serviceLocator()));
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(serviceLocator()))
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(remoteDataSource: serviceLocator(), serviceLocator()))
    ..registerFactory(() => UserSignup(authRepository: serviceLocator()))
    ..registerFactory(() => UserSignin(authRepository: serviceLocator()))
    ..registerFactory(() => CurrentUser(authRepository: serviceLocator()))
    ..registerLazySingleton(() => AuthBloc(serviceLocator(), serviceLocator(),
        serviceLocator(), serviceLocator()));
}

void _initBlog() {
  serviceLocator
    ..registerFactory<BlogRemoteDataSources>(
        () => BlogRemoteDataSourcesImpl(supabaseClient: serviceLocator()))
    
    ..registerFactory<BlogLocalDataSource>(
        () => BlogLocalDataSourceImpl(serviceLocator()))
    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(
        blogRemoteDataSources: serviceLocator(), serviceLocator(), serviceLocator()))
    ..registerFactory(() => UploadBlog(blogRepository: serviceLocator()))
    ..registerFactory(() => GetAllBlogs(blogRepository: serviceLocator()))
    ..registerLazySingleton(() => BlogBloc(serviceLocator(), serviceLocator()));
}
