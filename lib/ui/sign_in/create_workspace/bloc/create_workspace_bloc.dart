import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'create_workspace_event.dart';
import 'create_workspace_state.dart';

@Injectable()
class CreateWorkSpaceBloc
    extends Bloc<CreateWorkSpaceEvent, CreateWorkSpaceStates> {
  CreateWorkSpaceBloc() : super(CreateWorkSpaceInitialState()) {
    on<CreateWorkSpaceEvent>(_createSpace);
  }

  _createSpace(
      CreateWorkSpaceEvent events, Emitter<CreateWorkSpaceStates> emit) async {
    if (state is! CreateWorkSpaceLoadingState) {
      ///TODO: add implementation for create space
    }
  }
}
