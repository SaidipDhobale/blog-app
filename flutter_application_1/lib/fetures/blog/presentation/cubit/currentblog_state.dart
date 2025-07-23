part of 'currentblog_cubit.dart';


sealed class CurrentblogState {}

final class CurrentblogInitial extends CurrentblogState {}

final class BlogStateCurrent extends CurrentblogState{
  Blog blog;
  bool flag;
  BlogStateCurrent({required this.blog,required this.flag});
}