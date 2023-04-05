import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/ui/space/join_space/bloc/join_space_event.dart';
import 'package:projectunity/ui/space/join_space/bloc/join_space_state.dart';
import '../../../../data/services/space_service.dart';

@Injectable()
class JoinSpaceBloc extends Bloc<JoinSpaceEvents, JoinSpaceState> {
  final UserManager _userManager;
  final SpaceService _spaceService;

  JoinSpaceBloc(this._spaceService, this._userManager)
      : super(const JoinSpaceState()) {
    on<JoinSpaceInitialFetchEvent>(_init);
    on<SelectSpaceEvent>(_selectSpace);
  }


  String get userEmail => _userManager.userEmail?? "unknown";

  void _init(
      JoinSpaceInitialFetchEvent event, Emitter<JoinSpaceState> emit) async {
    emit(state.copy(getSpaceStatus: Status.loading));
    try {
      final spaces = await _spaceService.getSpacesOfUser(_userManager.userId!);
      emit(state.copy(getSpaceStatus: Status.success, spaces: spaces));
    } on Exception {
      emit(state.copy(
          getSpaceStatus: Status.failure, error: firestoreFetchDataError));
    }
  }

  void _selectSpace(SelectSpaceEvent event, Emitter<JoinSpaceState> emit) {

  }
}
