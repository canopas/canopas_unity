import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/admin/setting/edit_work_space/bloc/edit_workspace_event.dart';
import '../../../../../data/services/workspace_service.dart';
import 'edit_workspace_state.dart';

@Injectable()
class EditWorkSpaceBloc extends Bloc<EditWorkSpaceEvent, EditWorkspaceState> {
  final WorkspaceService _workspaceService;

  EditWorkSpaceBloc(this._workspaceService)
      : super(const EditWorkspaceState()) {
    on<EditWorkSpaceInitialEvent>(_init);

    on<CompanyNameChangeEvent>(_onNameChange);
    on<YearlyPaidTimeOffChangeEvent>(_timeOffChange);
    on<DeleteWorkspaceEvent>(_deleteWorkspace);
  }

  void _init(EditWorkSpaceInitialEvent event,
      Emitter<EditWorkspaceState> emit) async {}

  void _onNameChange(
      CompanyNameChangeEvent event, Emitter<EditWorkspaceState> emit) {
    emit(state.copyWith(nameIsValid: event.companyName.isNotEmpty));
  }

  void _timeOffChange(
      YearlyPaidTimeOffChangeEvent event, Emitter<EditWorkspaceState> emit) {
    try {
      int.parse(event.timeOff);
      emit(state.copyWith(yearlyPaidTimeOffIsValid: true));
    } on Exception {
      emit(state.copyWith(yearlyPaidTimeOffIsValid: false));
    }
  }

  void _deleteWorkspace(
      DeleteWorkspaceEvent event, Emitter<EditWorkspaceState> emit) {
    _workspaceService.deleteWorkspace(event.workspaceId);
  }
}
