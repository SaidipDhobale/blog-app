// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:flutter_application_1/fetures/blog/data/Models/post_image_model.dart';
import 'package:flutter_application_1/fetures/blog/domain/entities/blogentity.dart';
import 'package:flutter_application_1/fetures/blog/domain/entities/postimageentity.dart';
import 'package:flutter_application_1/fetures/blog/domain/usecase/add_blog_usecase.dart';
import 'package:flutter_application_1/fetures/blog/domain/usecase/delete_blog_usecase.dart';
import 'package:flutter_application_1/fetures/blog/domain/usecase/editblog_usecase.dart';
import 'package:flutter_application_1/fetures/blog/domain/usecase/fetch_my_blog.dart';
import 'package:flutter_application_1/fetures/blog/domain/usecase/fetch_usecase.dart';
import 'package:flutter_application_1/fetures/blog/domain/usecase/hiveimages_usecase.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  UploadBlog uploadBlog;
  FetchBlog fetchblog;
  EditdBlog editBlog;
  DeleteBlogUseCase deleteblog;
  HiveImageUseCase hiveImageUseCase;
  FetchMyBlog fetchMyBlog;
  BlogBloc(
    this.uploadBlog,
    this.fetchblog,
    this.editBlog,
    this.deleteblog,
    this.hiveImageUseCase,
    this.fetchMyBlog,
  ) : super(BlogInitial()) {
    
    on<BlogEvent>((event, emit) {
      emit(BlogLoading());
    });

    on<BlogUploadEvent>((event,emit)async{
      
      log("in blog upload bloc");
        final res=await uploadBlog(BlogParams(id: event.id, title: event.title, content: event.content, userid: event.userid, updatedAt: event.updatedAt, topics: event.topics,image: event.image));
        res.fold((l) =>emit(BlogUploadFailure()), (r) =>emit(BlogUploadSucess()));
    });

    on<FetchBlogEvent> (((event, emit)async {
        final res=await fetchblog(BlogParam());
        res.fold((l) => emit(BlogUploadFailure()), (r) =>emit(BlogFetchSucess(bloglist: r))) ;
    }));


    on<EditBlogEvent>((event, emit)async {
      final res=await editBlog(EditBlogParams(id: event.id, title: event.title, content: event.content, userid: event.userid, updatedAt: event.updatedAt, topics: event.topics,image: event.image,isImageChanged: event.isImageChanged));
      res.fold((l) => emit(BlogUploadFailure()), (r) => emit(BlogEditSucess()));
    },);

    on<DeleteBlogEvent>((event, emit)async {
        final res=await deleteblog(DeleteParam(id: event.id));
        res.fold((l) => emit(BlogDeleteFailure()), (r) =>emit(DeleteBlogSucess()));
    },);


    on<GetHiveImagesEvent>((event, emit)async {
      final res=await hiveImageUseCase(NothingParam());
      res.fold((l) => emit(BlogDeleteFailure()), (r) => emit(HiveImageFetchSucess(postimages: r)));
    },);

    on<FetchMyBlogEvent> (((event, emit)async {
        final res=await fetchMyBlog(MyBlogParam(userid: event.userid));
        res.fold((l) => emit(BlogUploadFailure()), (r) =>emit(MyBlogFetchSucess(mybloglist: r))) ;
    }));
  }
  @override
  void onChange(Change<BlogState> change) {
    log("${change.currentState}");
    super.onChange(change);
  }
  @override
  void onTransition(Transition<BlogEvent, BlogState> transition) {
    log("${transition.currentState}::${transition.nextState}");
    super.onTransition(transition);
  }

  
}
