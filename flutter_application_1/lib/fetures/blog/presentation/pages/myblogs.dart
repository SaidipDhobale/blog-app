import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/navbar/mybottomnavbar.dart';
import 'package:flutter_application_1/core/navbar/navbar.dart';
import 'package:flutter_application_1/core/usercubit/user_cubit.dart';
import 'package:flutter_application_1/fetures/blog/domain/entities/postimageentity.dart';
import 'package:flutter_application_1/fetures/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_application_1/fetures/blog/presentation/widgets/blogwidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlogs extends StatefulWidget {
  const MyBlogs({super.key});

  @override
  State<MyBlogs> createState() => _MyBlogsState();
}

class _MyBlogsState extends State<MyBlogs> {

  List<PostImageEntity>localimages=[];
  bool showMessage=false;

   @override
  void initState() {
  //   Future.microtask(() {
  //   final state = context.read<UserCubit>().state;
  //  log("usercubit state:--${state.toString()}");
  // //   if (state is UserLoggedIn) {
  // //     final userId = state.user.id;
  // //     context.read<BlogBloc>().add(FetchMyBlogEvent(userid: userId));
  // //   }
  // });
  final userId = (context.read<UserCubit>().state as UserLoggedIn).user.id;
    if (userId != null) {
      context.read<BlogBloc>().add(FetchMyBlogEvent(userid: userId));
  // Use userId
    }
    //final state = context.read<UserCubit>().state;
  //   final userId = context.read<UserCubit>().userId;
  //   if (userId != null) {
  //     context.read<BlogBloc>().add(FetchMyBlogEvent(userid: userId));
  // // Use userId
  //   }
  //   if (state is UserLoggedIn) {
  //   final userId = state.user.id;
  //   debugPrint("User ID in initState: $userId");

  //   // Now you can fetch blogs, profile, etc.
  //   context.read<BlogBloc>().add(FetchMyBlogEvent(userid: userId));
  // }
    // context.read<BlogBloc>().add(FetchMyBlogEvent());
   // context.read<BlogBloc>().add(GetHiveImagesEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MyBottomNavBar(currentIndex: 2,),
      appBar: AppBar(title:const Text("My Blogs"),),
      body: MyBlogWidget(localimages: localimages, showMessage: showMessage),
    );
  }
}