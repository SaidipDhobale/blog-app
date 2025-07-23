import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_palate.dart';
import 'package:flutter_application_1/fetures/blog/domain/entities/blogentity.dart';
import 'package:flutter_application_1/fetures/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_application_1/fetures/blog/presentation/cubit/currentblog_cubit.dart';
import 'package:flutter_application_1/fetures/blog/presentation/pages/add_blog_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class MyCard extends StatefulWidget {
  final Blog blog;
  final int index;
    bool showMessage;
   MyCard({super.key,required this.blog,required this.index,required this.showMessage});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
                              elevation: 8, // Higher = stronger shadow
                              shadowColor: AppPallete.whiteColor.withOpacity(0.7),
                              color: AppPallete.cardcolor[widget.index % 5],
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Wrap(
                                        spacing: 6,
                                        children: widget.blog.topics
                                            .map((topic) => Chip(
                                                  color:
                                                      const MaterialStatePropertyAll(
                                                          AppPallete.gradient2),
                                                  label: Text(topic),
                                                  visualDensity:
                                                      const VisualDensity(
                                                          horizontal: -2,
                                                          vertical: -2),
                                                ))
                                            .toList(),
                                      ),
                                      // Image
                                      if (widget.blog.image_url.isNotEmpty)
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            widget.blog.image_url,
                                            height: 180,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                  
                                      const SizedBox(height: 8),
                  
                                      // Title
                                      Text(
                                        widget.blog.title,
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
                                        widget.blog.content,
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
                                                .format(widget.blog.updated_at),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(color: Colors.black87),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                              onPressed: () {
                                                context
                                                    .read<CurrentblogCubit>()
                                                    .setCurrentBlog(widget.blog, true);
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
                                              onPressed: ()  async{
                                                context.read<BlogBloc>().add(DeleteBlogEvent(id: widget.blog.id));
                                                
                                                context.read<BlogBloc>().add(FetchBlogEvent());
                                                await Future.delayed(const Duration(seconds: 1));
                                                setState(() {
                                                  widget.showMessage = true;
                                                });
                  
                                                // Hide after 2 seconds
                                                await Future.delayed(
                                                    const Duration(seconds: 2));
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
  }
}