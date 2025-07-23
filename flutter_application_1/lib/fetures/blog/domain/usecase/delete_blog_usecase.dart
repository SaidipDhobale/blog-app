import 'dart:developer';

import 'package:flutter_application_1/core/error/failure.dart';
import 'package:flutter_application_1/core/usecases/usecase.dart';
import 'package:flutter_application_1/fetures/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/src/either.dart';

class DeleteBlogUseCase implements Usecase<String, DeleteParam> {
  BlogRepository blogRepository;
  DeleteBlogUseCase({
    required this.blogRepository,
  });

  @override
  Future<Either<Failure, String>> call(DeleteParam param)async {
    log("3:sucess");
    return await  blogRepository.deleteBlock(id: param.id);
  }
}

class DeleteParam {
  String id;
  DeleteParam({required this.id});
}
