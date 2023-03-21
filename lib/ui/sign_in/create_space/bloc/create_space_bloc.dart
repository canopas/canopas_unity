import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/sign_in/create_space/bloc/create_space_event.dart';
import 'package:projectunity/ui/sign_in/create_space/bloc/create_space_state.dart';

@Injectable()
class CreateSpaceBloc extends Bloc<CreateSpaceEvent, CreateSpaceStates> {
  CreateSpaceBloc() : super(CreateSpaceInitialState()) {
    on<CreateSpaceEvent>(_createSpace);
  }

  _createSpace(CreateSpaceEvent events, Emitter<CreateSpaceStates> emit) async {
    ///TODO: add implementation for create space
  }
}
