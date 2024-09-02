import 'package:blog_nest/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BlogPage extends StatelessWidget {
  static const routeName = '/blog-page';
  const BlogPage({super.key});
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
    );
  }
}
