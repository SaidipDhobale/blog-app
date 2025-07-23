import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/notifications/serverkey.dart';
import 'package:flutter_application_1/core/theme/app_palate.dart';
import 'package:flutter_application_1/core/usercubit/user_cubit.dart';
import 'package:flutter_application_1/core/utils/image_picker.dart';
import 'package:flutter_application_1/fetures/blog/domain/entities/blogentity.dart';
import 'package:flutter_application_1/fetures/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_application_1/fetures/blog/presentation/cubit/currentblog_cubit.dart';
import 'package:flutter_application_1/fetures/blog/presentation/pages/blog_page.dart';
import 'package:flutter_application_1/fetures/blog/presentation/widgets/blog_type_list.dart';
import 'package:flutter_application_1/fetures/blog/presentation/widgets/icon.dart';
import 'package:flutter_application_1/core/utils/imaged.dart';
import 'package:flutter_application_1/fetures/blog/presentation/widgets/imagepreview.dart';
import 'package:flutter_application_1/fetures/blog/presentation/widgets/textfield.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({super.key});
  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  String message = "";
  bool imageChangeFlag = false;
  File? image;
  Blog? currentblog;
  String? currentimage;
  List<String> selectedBlogType = [];
  TextEditingController titlec = TextEditingController();
  TextEditingController contentc = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    titlec.dispose();
    contentc.dispose();
  }

  void getimage() async {
    image = await downloadImageToFile(currentblog!.image_url);
  }

  @override
  void initState() {
    final state = context.read<CurrentblogCubit>().state;

    // Use pattern‑matching instead of a forced cast
    if (state is BlogStateCurrent && state.flag) {
      currentblog = state.blog;
      selectedBlogType = currentblog!.topics;

      getimage();
    }
    titlec = TextEditingController(text: currentblog?.title ?? '');
    contentc = TextEditingController(text: currentblog?.content ?? '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final local=AppLocalizations.of(context)!;
    return BlocConsumer<BlogBloc, BlogState>(
      listener: (context, state) {
        if (state is BlogUploadSucess || state is BlogEditSucess) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MyBlog()),
              (route) => false);
        }
      },
      builder: (context, state) {
        if (state is BlogLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: AppBar(
            actions: [
              AddIcon(
                onPressed: () async {
                  String userid="";
                  if (currentblog != null) {
                    log(currentblog.toString());
                    context.read<BlogBloc>().add(EditBlogEvent(
                        id: currentblog!.id,
                        title: titlec.text,
                        content: contentc.text,
                        userid: currentblog!.userid,
                        updatedAt: DateTime.now().toIso8601String(),
                        topics: selectedBlogType,
                        image: image!,
                        isImageChanged: imageChangeFlag));
                    message = "updated";
                  } else if (image != null) {
                     userid =
                        (context.read<UserCubit>().state as UserLoggedIn)
                            .user
                            .id;
                    log(userid);
                    context.read<BlogBloc>().add(BlogUploadEvent(
                        id: const Uuid().v4(),
                        title: titlec.text,
                        content: contentc.text,
                        userid: userid,
                        updatedAt: DateTime.now().toIso8601String(),
                        topics: selectedBlogType,
                        image: image!));
                    message = "added";
                  }
                  //------------------messaging-----------------
                  final get = GetServerKey();
                  String token = await get.serverToken();
                  final response = await http.post(
                    Uri.parse(
                        'https://fcm.googleapis.com/v1/projects/blogmessage/messages:send'),
                    //"https://fcm.googleapis.com/fcm/send"),
                    headers: <String, String>{
                      'Content-Type': 'application/json',
                      'Authorization': 'Bearer $token',
                    },
                    body: jsonEncode(<String, dynamic>{
                      "message": {
                        "topic": "all_users",
                        //"token":fCMToken,
                        //"to": "/topics/all_users",
                        "notification": {
                          "body": 'New Blog is $message',
                          "title": 'Blogs',
                        },
                        "data": {
                          "story_id": "story_12345",
                          "sender_id":userid
                        }
                      }
                    }),
                  );
                  // final response = await http.post(
                  //   Uri.parse('https://fcm.googleapis.com/v1/projects/blogmessage/messages:send'),
                  //   headers: <String, String>{
                  //     'Content-Type': 'application/json',
                  //     'Authorization':
                  //         'key=$token', // 🔑 Replace with your actual key
                  //   },
                  //   body: jsonEncode({
                  //     "to": "/topics/all_users",
                  //     "notification": {
                  //       "title": "Blogs",
                  //       "body": "New Blog is $message",
                  //     },
                  //     "data": {
                  //       "story_id": "story_12345",
                  //     }
                  //   }),
                  // );

                  log("${response.statusCode}");
                  log(response.body);
                },
                name: Icons.done,
                size: 30,
              )
            ],
            title: Text(
              currentblog == null ? local.addBlog : local.editBlog,
              style: const TextStyle(
                  color: AppPallete.gradient1,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      imageChangeFlag = true;
                      image = await pickImage();
                      setState(() {});
                    },
                    child: imagePreview(image, currentblog),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlogTypeSelector(
                    selectedTopics: selectedBlogType,
                    onTypeSelected: (type) {
                      log("selectedblogstopics:$selectedBlogType");
                      selectedBlogType = type;
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(controller: titlec, hintext: local.title),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(controller: contentc, hintext: local.content),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
