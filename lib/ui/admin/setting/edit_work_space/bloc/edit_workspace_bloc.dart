import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/admin/setting/edit_work_space/bloc/edit_workspace%20_state.dart';
import 'package:projectunity/ui/admin/setting/edit_work_space/bloc/edit_workspace_event.dart';

@Injectable()
class EditWorkSpaceBloc extends Bloc<EditWorkSpaceEvent, EditWorkspaceStates> {
  EditWorkSpaceBloc() : super(EditWorkspaceInitialState()) {
    on<EditWorkSpaceInitialEvent>(_init);
  }

  _init(EditWorkSpaceInitialEvent events,
      Emitter<EditWorkspaceStates> emit) async {
  }
}
