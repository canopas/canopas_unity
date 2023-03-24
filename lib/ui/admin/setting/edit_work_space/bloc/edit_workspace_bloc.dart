import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/admin/setting/edit_work_space/bloc/edit_workspace_event.dart';
import 'edit_workspace_state.dart';

@Injectable()
class EditWorkSpaceBloc extends Bloc<EditWorkSpaceEvent, EditWorkspaceState> {
  EditWorkSpaceBloc() : super(const EditWorkspaceState()) {
    on<EditWorkSpaceInitialEvent>(_init);

    on<CompanyNameChangeEvent>(_onNameChange);
    on<YearlyPaidTimeOffChangeEvent>(_timeOffChange);
  }

  _init(EditWorkSpaceInitialEvent event,
      Emitter<EditWorkspaceState> emit) async {}

  _onNameChange(
      CompanyNameChangeEvent event, Emitter<EditWorkspaceState> emit) async {
    emit(state.copyWith(nameIsValid: event.companyName.isNotEmpty));
  }

  _timeOffChange(YearlyPaidTimeOffChangeEvent event,
      Emitter<EditWorkspaceState> emit) async {
    try {
      int.parse(event.timeOff);
      emit(state.copyWith(yearlyPaidTimeOffIsValid: true));
    } on Exception {
      emit(state.copyWith(yearlyPaidTimeOffIsValid: false));
    }
  }
}
