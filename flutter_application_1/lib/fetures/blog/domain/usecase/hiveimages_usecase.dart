// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/src/either.dart';

import 'package:flutter_application_1/core/error/failure.dart';
import 'package:flutter_application_1/core/usecases/usecase.dart';
import 'package:flutter_application_1/fetures/blog/domain/entities/postimageentity.dart';
import 'package:flutter_application_1/fetures/blog/domain/repository/blog_repository.dart';

class HiveImageUseCase implements Usecase<List<PostImageEntity>,NothingParam> {
  BlogRepository blogRepository;
  HiveImageUseCase({
    required this.blogRepository,
  });
  
  @override
  Future<Either<Failure, List<PostImageEntity>>> call(NothingParam param)async {
    return await blogRepository.getAllImagesFromHive();
  }

}

class NothingParam{

}