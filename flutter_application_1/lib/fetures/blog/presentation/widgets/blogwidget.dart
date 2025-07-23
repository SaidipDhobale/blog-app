// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/fetures/blog/domain/entities/blogentity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_1/core/theme/app_palate.dart';
import 'package:flutter_application_1/fetures/blog/domain/entities/postimageentity.dart';
import 'package:flutter_application_1/fetures/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_application_1/fetures/blog/presentation/cubit/currentblog_cubit.dart';
import 'package:flutter_application_1/fetures/blog/presentation/pages/add_blog_page.dart';
import 'package:flutter_application_1/fetures/blog/presentation/widgets/delete_alert.dart';
import 'package:intl/intl.dart';

class MyBlogWidget extends StatefulWidget {
 List<PostImageEntity> localimages;
 bool showMessage=false;
 MyBlogWidget({
    super.key,
    required this.localimages,
    required this.showMessage,
  });

  @override
  State<MyBlogWidget> createState() => _MyBlogWidgetState();
}

class _MyBlogWidgetState extends State<MyBlogWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogBloc, BlogState>(builder: (context, state) {
            if (state is DeleteBlogSucess) {
              log("deleted state");
            }
            if (state is HiveImageFetchSucess) {
              log("hive stored no of images:-${state.postimages.length}");
              widget.localimages = state.postimages;
              log("${widget.localimages.length}");
            }

            if (state is MyBlogFetchSucess) {
              List<Blog> blogList = state.mybloglist;

              log("my local images localimageslength:-${widget.localimages.length}");
              return SafeArea(
                bottom: true,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 200.0),
                    child: Stack(children: [
                      Column(
                        children: [
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey.shade300,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height -
                                kToolbarHeight -
                                MediaQuery.of(context).padding.top -
                                100,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: blogList.length,
                              itemBuilder: (context, index) {
                                final blog = blogList[index];

                                return Card(
                                  elevation: 8, // Higher = stronger shadow
                                  shadowColor:
                                      AppPallete.whiteColor.withOpacity(0.7),
                                  color: AppPallete.cardcolor[index % 5],
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Wrap(
                                            spacing: 6,
                                            children: blog.topics
                                                .map((topic) => Chip(
                                                      color:
                                                          const MaterialStatePropertyAll(
                                                              AppPallete
                                                                  .gradient2),
                                                      label: Text(topic),
                                                      visualDensity:
                                                          const VisualDensity(
                                                              horizontal: -2,
                                                              vertical: -2),
                                                    ))
                                                .toList(),
                                          ),
                                          // Image
                                          (widget.localimages.isNotEmpty &&
                                                  widget.localimages[index].postId ==
                                                      blog.id)
                                              ? ClipRRect(
                                                  child: Image.memory(
                                                    widget.localimages[index]
                                                        .imageBytes,
                                                    fit: BoxFit.cover,
                                                    height: 180,
                                                    width: double.infinity,
                                                  ),
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(
                                                    blog.image_url,
                                                    height: 180,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),

                                          const SizedBox(height: 8),

                                          // Title
                                          Text(
                                            blog.title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color.fromRGBO(
                                                        51, 51, 51, 1.0)),
                                          ),
                                          // Content preview (max 3 lines)
                                          const SizedBox(height: 8),
                                          Text(
                                            blog.content,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: const Color.fromARGB(
                                                        255, 26, 24, 24)),
                                          ),

                                          const SizedBox(height: 8),

                                          // Topics chips

                                          Row(
                                            children: [
                                              Text(
                                                DateFormat('MMM d, y')
                                                    .format(blog.updated_at),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color: Colors.black87),
                                              ),
                                              const Spacer(),
                                              IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                            CurrentblogCubit>()
                                                        .setCurrentBlog(
                                                            blog, true);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                const AddBlog()));
                                                  },
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    color: AppPallete.gradient1,
                                                  )),
                                              IconButton(
                                                  onPressed: () async {
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (context) =>
                                                          CustomDeleteDialog(
                                                        onConfirm: () {
                                                          context
                                                              .read<BlogBloc>()
                                                              .add(
                                                                  DeleteBlogEvent(
                                                                      id: blog
                                                                          .id));

                                                          context
                                                              .read<BlogBloc>()
                                                              .add(
                                                                  FetchBlogEvent());
                                                          Navigator.of(context)
                                                              .pop(); // Close the dialog
                                                          // Execute your delete logic
                                                        },
                                                        onCancel: () {
                                                          Navigator.of(context)
                                                              .pop(); // Just close
                                                        },
                                                      ),
                                                    );

                                                    await Future.delayed(
                                                        const Duration(
                                                            seconds: 1));
                                                    setState(() {
                                                      widget.showMessage = true;
                                                    });

                                                    // Hide after 2 seconds
                                                    await Future.delayed(
                                                        const Duration(
                                                            seconds: 2));
                                                    setState(() {
                                                      widget.showMessage = false;
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: AppPallete.gradient1,
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          });
  }
}