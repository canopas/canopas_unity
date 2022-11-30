import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../navigation/nav_stack/nav_stack_item.dart';
import '../../../navigation/navigation_stack_manager.dart';
import '../../../pref/user_preference.dart';
import 'onboard_event.dart';

@Injectable()
class OnBoardBloc extends Bloc<OnBoardEvent,int>{

  final UserPreference _preference;
  final NavigationStackManager _navigationStackManager;
  OnBoardBloc(this._preference, this._navigationStackManager) : super(0){
    on<SetOnBoardCompletedEvent>(_setOnBoardCompleted);
    on<CurrentPageChangeEvent>(_onCurrentPageChange);
  }

  void _setOnBoardCompleted(SetOnBoardCompletedEvent event, Emitter<int> emit) {
    _preference.setOnBoardCompleted(true);
    _navigationStackManager.clearAndPush(const LoginNavStackItem());
  }

  void _onCurrentPageChange(CurrentPageChangeEvent event,  Emitter<int> emit){
    emit(event.page);
  }

}

