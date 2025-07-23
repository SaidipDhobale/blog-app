import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navbar_event.dart';
part 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(const NavbarInitial()) {

    
    on<NavigationTabChanged>((event, emit) {
      emit(NavigationState(event.index));
    });
  }
}
