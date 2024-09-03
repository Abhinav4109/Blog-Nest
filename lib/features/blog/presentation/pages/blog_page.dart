import 'package:blog_nest/core/common/widgets/loader.dart';
import 'package:blog_nest/core/common/widgets/snackbar.dart';
import 'package:blog_nest/core/theme/app_pallete.dart';
import 'package:blog_nest/features/blog/bloc/blog_bloc.dart';
import 'package:blog_nest/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_nest/features/blog/presentation/pages/blog_view_page.dart';
import 'package:blog_nest/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BlogPage extends StatefulWidget {
  static const routeName = '/blog-page';
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Nest'),
        actions: [
          IconButton(
              onPressed: () {
                GoRouter.of(context).pushNamed(AddNewBlogPage.routeName);
              },
              icon: const Icon(CupertinoIcons.add_circled)),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(listener: (context, state) {
        if (state is BlogFailure) {
          showSnackBar(context, state.error);
        }
      }, builder: (context, state) {
        if (state is BlogLoading) {
          return const Loader();
        }
        if (state is BlogFetchSucess) {
          return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return GestureDetector(
                    onTap: () =>
                        context.pushNamed(BlogViewPage.routeName, extra: blog),
                    child: BlogCard(
                        blog: blog,
                        color: index % 2 == 0
                            ? AppPallete.gradient1
                            : AppPallete.gradient2));
              });
        }
        return const SizedBox();
      }),
    );
  }
}
