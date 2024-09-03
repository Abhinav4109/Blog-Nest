import 'package:blog_nest/core/theme/app_pallete.dart';
import 'package:blog_nest/core/utils/calculate_reading_time.dart';
import 'package:blog_nest/core/utils/format_date.dart';
import 'package:blog_nest/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogViewPage extends StatelessWidget {
  static const routeName = '/blog-view-page';
  final Blog blog;
  const BlogViewPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16).copyWith(top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'By ${blog.posterName}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                  '${formatDateBydMMMYYYY(blog.updatedAt)}. ${calculateReadingTime(content: blog.content)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppPallete.greyColor,
                    fontSize: 16,
                  ),
                ),
               
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(blog.imageUrl),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    blog.content,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 2,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
