import 'package:blog_nest/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_nest/core/theme/theme.dart';
import 'package:blog_nest/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_nest/features/blog/bloc/blog_bloc.dart';
import 'package:blog_nest/init_dependencies.dart';
import 'package:blog_nest/routes/app_route_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
      BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
      BlocProvider(create: (_) => serviceLocator<BlogBloc>())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(IsUserSignedIn());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUserCubit, AppUserState>(builder: (context, state) {
      return MaterialApp.router(
        routerConfig: AppRouter(state: state).router,
        debugShowCheckedModeBanner: false,
        title: 'Blog Nest',
        theme: AppTheme.darkThemeMode,
      );
    });
  }
}
