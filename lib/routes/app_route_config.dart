import 'package:blog_nest/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_nest/features/auth/presentation/pages/signin_page.dart';
import 'package:blog_nest/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_nest/features/blog/domain/entities/blog.dart';
import 'package:blog_nest/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_nest/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_nest/features/blog/presentation/pages/blog_view_page.dart';
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
            name: BlogPage.routeName,
            path: BlogPage.routeName,
            builder: (_, state) => const BlogPage()),
        GoRoute(
            name: AddNewBlogPage.routeName,
            path: AddNewBlogPage.routeName,
            builder: (_, state) => const AddNewBlogPage()),
        GoRoute(
            name: BlogViewPage.routeName,
            path: BlogViewPage.routeName,
            builder: (_, state) {
              final blog = state.extra as Blog;
              return BlogViewPage(blog: blog);
            })
      ]);

  String _getInitialLocation(AppUserState state) {
    if (state is AppUserSignedIn) {
      return BlogPage.routeName;
    } else {
      return SigninPage.routeName;
    }
  }
}
