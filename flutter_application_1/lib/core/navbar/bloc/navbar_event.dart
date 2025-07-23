part of 'navbar_bloc.dart';

@immutable
sealed class NavbarEvent {}

class NavigationTabChanged extends NavbarEvent {
  final int index;
  NavigationTabChanged(this.index);
}