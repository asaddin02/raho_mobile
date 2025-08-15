import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(BottomNavigationState(currentIndex: 0));

  void setIndex(int index){
    emit(BottomNavigationState(currentIndex: index));
  }
}
