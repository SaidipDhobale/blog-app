import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/fetures/blog/domain/entities/blogentity.dart';
import 'package:meta/meta.dart';

part 'currentblog_state.dart';

class CurrentblogCubit extends Cubit<CurrentblogState> {
  CurrentblogCubit() : super(CurrentblogInitial());

  void setCurrentBlog(Blog blog,bool flag){
      emit(BlogStateCurrent(blog: blog,flag: flag));
  }
}
