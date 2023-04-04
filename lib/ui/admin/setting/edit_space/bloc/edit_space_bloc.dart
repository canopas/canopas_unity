import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/services/space_service.dart';
import 'edit_space_state.dart';
import 'edit_space_event.dart';

@Injectable()
class EditWorkSpaceBloc extends Bloc<EditSpaceEvent, EditWorkspaceState> {
  final SpaceService _spaceService;

  EditWorkSpaceBloc(this._spaceService) : super(const EditWorkspaceState()) {
    on<EditSpaceInitialEvent>(_init);

    on<CompanyNameChangeEvent>(_onNameChange);
    on<YearlyPaidTimeOffChangeEvent>(_timeOffChange);
    on<DeleteSpaceEvent>(_deleteWorkspace);
  }

  void _init(EditSpaceInitialEvent event,
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
      DeleteSpaceEvent event, Emitter<EditWorkspaceState> emit) {
    try {
      emit(state.copyWith(deleteWorkSpaceStatus: Status.loading));
      _spaceService.deleteSpace(event.workspaceId);
      emit(state.copyWith(deleteWorkSpaceStatus: Status.success));
    } on Exception {
      emit(state.copyWith(
          deleteWorkSpaceStatus: Status.failure,
          error: somethingWentWrongError));
    }
  }
}
