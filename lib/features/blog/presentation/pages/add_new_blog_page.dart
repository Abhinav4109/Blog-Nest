import 'dart:io';

import 'package:blog_nest/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_nest/core/common/widgets/loader.dart';
import 'package:blog_nest/core/common/widgets/snackbar.dart';
import 'package:blog_nest/core/theme/app_pallete.dart';
import 'package:blog_nest/core/utils/pick_image.dart';
import 'package:blog_nest/features/blog/bloc/blog_bloc.dart';
import 'package:blog_nest/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_nest/features/blog/presentation/widgets/blog_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});
  static const routeName = '/add-new-blog';
  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  List<String> selectedTopics = [];
  File? image;
  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadBlog() {
    if (_formkey.currentState!.validate() &&
        image != null &&
        selectedTopics.isNotEmpty) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserSignedIn).user.id;
          
      context.read<BlogBloc>().add(BlogUpload(
          file: image!,
          title: _titleController.text.trim(),
          content: _contentController.text.trim(),
          posterId: posterId,
          topics: selectedTopics));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: uploadBlog, icon: const Icon(Icons.done_outlined))
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
            print(state.error);
          } else if (state is BlogSuccess) {
            context.go(BlogPage.routeName);
          }
        },
        builder: (context, state) {
          if(state is BlogLoading){
            return const Loader();
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      image!,
                                      fit: BoxFit.cover,
                                    ))),
                          )
                        : GestureDetector(
                            onTap: selectImage,
                            child: DottedBorder(
                                color: AppPallete.borderColor,
                                dashPattern: const [10, 4],
                                radius: const Radius.circular(10),
                                borderType: BorderType.RRect,
                                strokeCap: StrokeCap.round,
                                child: const SizedBox(
                                  height: 150,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.folder_open,
                                        size: 40,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Select your image',
                                        style: TextStyle(fontSize: 15),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            'Buisness',
                            'Technology',
                            'Gadegts',
                            'Cars',
                          ]
                              .map(
                                (e) => Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (selectedTopics.contains(e)) {
                                          selectedTopics.remove(e);
                                        } else {
                                          selectedTopics.add(e);
                                        }
                                        setState(() {});
                                      },
                                      child: Chip(
                                        label: Text(e),
                                        color: selectedTopics.contains(e)
                                            ? const WidgetStatePropertyAll(
                                                AppPallete.gradient1)
                                            : null,
                                        side: BorderSide(
                                            color: selectedTopics.contains(e)
                                                ? Colors.transparent
                                                : AppPallete.borderColor),
                                      ),
                                    )),
                              )
                              .toList(),
                        )),
                    const SizedBox(height: 15),
                    BlogField(
                        controller: _titleController, hintText: 'Blog Title'),
                    const SizedBox(
                      height: 10,
                    ),
                    BlogField(
                        controller: _contentController,
                        hintText: 'Blog Content')
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
