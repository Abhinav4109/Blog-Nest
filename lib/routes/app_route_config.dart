import 'package:blog_nest/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_nest/features/auth/presentation/pages/home.dart';
import 'package:blog_nest/features/auth/presentation/pages/signin_page.dart';
import 'package:blog_nest/features/auth/presentation/pages/signup_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final AppUserState state;
  AppRouter({required this.state});
  GoRouter get router =>
      GoRouter(initialLocation: _getInitialLocation(state), routes: [
        GoRoute(
            name: SigninPage.routeName,
            path: SigninPage.routeName,
            builder: (_, state) => const SigninPage()),
        GoRoute(
          name: SignupPage.routeName,
          path: SignupPage.routeName,
          builder: (_, state) => const SignupPage(),
        ),
        GoRoute(
            name: Homeee.routeName,
            path: Homeee.routeName,
            builder: (_, state) => const Homeee())
      ]);

  String _getInitialLocation(AppUserState state) {
    if (state is AppUserSignedIn) {
      return Homeee.routeName;
    } else {
      return SigninPage.routeName;
    }
  }
}
