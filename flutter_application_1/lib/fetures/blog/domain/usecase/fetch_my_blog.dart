import 'dart:developer';

import 'package:flutter_application_1/core/error/failure.dart';
import 'package:flutter_application_1/core/usecases/usecase.dart';
import 'package:flutter_application_1/fetures/blog/domain/entities/blogentity.dart';
import 'package:flutter_application_1/fetures/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchMyBlog implements Usecase<List<Blog>,MyBlogParam> {
    BlogRepository blogRepository;
  FetchMyBlog( {
    required this.blogRepository,
  });
    
    @override
  Future<Either<Failure, List<Blog>>> call(param) async{
    log("in blog upload usecase");
   return await blogRepository.fetchMyAllBlog( userid: param.userid);
  }
}
class MyBlogParam{
  String userid;
  MyBlogParam({required this.userid});
}