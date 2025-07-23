import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/navbar/mybottomnavbar.dart';
import 'package:flutter_application_1/core/notifications/notification_service.dart';
import 'package:flutter_application_1/core/theme/app_palate.dart';
import 'package:flutter_application_1/core/usercubit/user_cubit.dart';
import 'package:flutter_application_1/fetures/Auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_application_1/fetures/Auth/presentation/pages/login_page.dart';
import 'package:flutter_application_1/fetures/Auth/presentation/widgets/alert_dialogue.dart';
import 'package:flutter_application_1/fetures/blog/data/Models/post_image_model.dart';
import 'package:flutter_application_1/fetures/blog/domain/entities/blogentity.dart';
import 'package:flutter_application_1/fetures/blog/domain/entities/postimageentity.dart';
import 'package:flutter_application_1/fetures/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_application_1/fetures/blog/presentation/cubit/currentblog_cubit.dart';
import 'package:flutter_application_1/fetures/blog/presentation/pages/add_blog_page.dart';
import 'package:flutter_application_1/fetures/blog/presentation/widgets/delete_alert.dart';
import 'package:flutter_application_1/fetures/blog/presentation/widgets/delete_message.dart';
import 'package:flutter_application_1/fetures/blog/presentation/widgets/icon.dart';
import 'package:flutter_application_1/fetures/profile/domain/entity/profile_entity.dart';
import 'package:flutter_application_1/fetures/profile/presentation/profilepage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class MyBlog extends StatefulWidget {
  const MyBlog({super.key});

  @override
  State<MyBlog> createState() => _MyBlogState();
}

class _MyBlogState extends State<MyBlog> {
  List<PostImageEntity> localimages = [];
  bool _showMessage = false;
  
  @override
  void initState() {
    
    context.read<BlogBloc>().add(FetchBlogEvent());
    context.read<BlogBloc>().add(GetHiveImagesEvent());
    final user=context.read<UserCubit>().userId;
    //------------------------------
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("onMessage: $message");
      String payloadData = jsonEncode(message.data);
      if (message.notification != null && user != message.data['sender_id'] ) {
        PushNotifications.showSimpleNotification(
            title: message.notification!.title!,
            body: message.notification!.body!,
            payload: payloadData);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("onMessageOpenedApp: $message");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is DeleteBlogSucess) {
          log("auth delte sucess");
        }
        if (state is AuthInitial) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false);
        }
      },
      builder: (context, state) {
        
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppPallete.gradient2,
            onPressed: (){
              final state = context.read<CurrentblogCubit>().state;
            
                    if (state is BlogStateCurrent && state.flag) {
                      state.flag = false;
                    }
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const AddBlog()));
            },
            child: const Icon(Iconsax.add_circle,size: 30,)
          ) ,
          bottomNavigationBar: const MyBottomNavBar(currentIndex: 0),
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthLogOut());
                  
                },
                icon: const Icon(Icons.logout_outlined)),
            title:  Text(
              AppLocalizations.of(context)!.blogs,
              style: const TextStyle(
                  color: AppPallete.greyColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              AddIcon(
                onPressed: () {
                  
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ProfilePage()));
                },
                name: Iconsax.profile_circle,
                size: 30,
              )
            ],
          ),
          body: BlocBuilder<BlogBloc, BlogState>(builder: (context, state) {
            if (state is DeleteBlogSucess) {
              log("deleted state");
            }
            if (state is HiveImageFetchSucess) {
              log("hive stored no of images:-${state.postimages.length}");
              localimages = state.postimages;
              log("${localimages.length}");
            }

            if (state is BlogFetchSucess) {
              List<Blog> blogList = state.bloglist;

              log("localimageslength:-${localimages.length}");
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
                                          (localimages.isNotEmpty && localimages.length>index&&
                                                  localimages[index].postId ==
                                                      blog.id)
                                              ? ClipRRect(
                                                  child: Image.memory(
                                                    localimages[index]
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
                                                      _showMessage = true;
                                                    });

                                                    // Hide after 2 seconds
                                                    await Future.delayed(
                                                        const Duration(
                                                            seconds: 2));
                                                    setState(() {
                                                      _showMessage = false;
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
          }),
        );
      },
    );
  }
}
