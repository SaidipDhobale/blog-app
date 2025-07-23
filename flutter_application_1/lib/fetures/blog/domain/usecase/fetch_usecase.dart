import 'dart:developer';

import 'package:flutter_application_1/core/error/failure.dart';
import 'package:flutter_application_1/core/usecases/usecase.dart';
import 'package:flutter_application_1/fetures/blog/domain/entities/blogentity.dart';
import 'package:flutter_application_1/fetures/blog/domain/repository/blog_repository.dart';
import 'package:flutter_application_1/fetures/blog/domain/usecase/add_blog_usecase.dart';
import 'package:fpdart/fpdart.dart';

class FetchBlog implements Usecase<List<Blog>,BlogParam> {
    BlogRepository blogRepository;
  FetchBlog({
    required this.blogRepository,
  });
    
    @override
  Future<Either<Failure, List<Blog>>> call(param) async{
    log("in blog upload usecase");
   return await blogRepository.fetchBlock();
  }
}
class BlogParam{

}