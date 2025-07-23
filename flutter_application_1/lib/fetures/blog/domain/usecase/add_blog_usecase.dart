// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:fpdart/src/either.dart';

import 'package:flutter_application_1/core/error/failure.dart';
import 'package:flutter_application_1/core/usecases/usecase.dart';
import 'package:flutter_application_1/fetures/blog/domain/entities/blogentity.dart';
import 'package:flutter_application_1/fetures/blog/domain/repository/blog_repository.dart';

class UploadBlog implements Usecase<Blog,BlogParams> {
    BlogRepository blogRepository;
  UploadBlog({
    required this.blogRepository,
  });
    
    @override
  Future<Either<Failure, Blog>> call(param) async{
    log("in blog upload usecase");
   return await blogRepository.addBlog(title: param.title, content: param.content, userid: param.userid, updatedAt: param.updatedAt, id: param.id, topics: param.topics,image: param.image);
  }
}

class BlogParams {
  final String id;
  final String title;
  final String content;
  final String userid;
  final String updatedAt;
  final File image;
  final List<String> topics;

  BlogParams({
    required this.id,
    required this.image,
    required this.title,
    required this.content,
    required this.userid,
    required this.updatedAt,
    required this.topics,
  });

  
}
