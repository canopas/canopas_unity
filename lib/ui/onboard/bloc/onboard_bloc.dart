import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/provider/user_data.dart';
import '../../../pref/user_preference.dart';
import 'onboard_event.dart';

@Injectable()
class OnBoardBloc extends Bloc<OnBoardEvent,int>{

  final UserPreference _preference;
  final UserManager _userManager;
  OnBoardBloc(this._preference,this._userManager) : super(0){
    on<SetOnBoardCompletedEvent>(_setOnBoardCompleted);
    on<CurrentPageChangeEvent>(_onCurrentPageChange);
  }

  void _setOnBoardCompleted(SetOnBoardCompletedEvent event, Emitter<int> emit) {
    _preference.setOnBoardCompleted(true);
    _userManager.hasOnBoarded();
  }

  void _onCurrentPageChange(CurrentPageChangeEvent event,  Emitter<int> emit){
    emit(event.page);
  }

}

