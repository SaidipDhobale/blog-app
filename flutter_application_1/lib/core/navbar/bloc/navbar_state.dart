part of 'navbar_bloc.dart';

@immutable
sealed class NavbarState {
  const NavbarState(this.index);
  final int index;
}

final class NavbarInitial extends NavbarState {

  const NavbarInitial() : super(0);         
}

final class NavigationState extends NavbarState {
  
   const NavigationState(super.index);
}