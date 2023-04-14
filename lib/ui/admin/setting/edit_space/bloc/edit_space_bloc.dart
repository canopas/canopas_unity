import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/services/space_service.dart';
import '../../../../../data/model/space/space.dart';
import '../../../../../data/provider/user_data.dart';
import 'edit_space_state.dart';
import 'edit_space_event.dart';

@Injectable()
class EditSpaceBloc extends Bloc<EditSpaceEvent, EditSpaceState> {
  final UserManager _userManager;
  final SpaceService _spaceService;

  EditSpaceBloc(this._spaceService, this._userManager)
      : super(const EditSpaceState()) {
    on<EditSpaceInitialEvent>(_init);

    on<CompanyNameChangeEvent>(_onNameChange);
    on<YearlyPaidTimeOffChangeEvent>(_timeOffChange);
    on<DeleteSpaceEvent>(_deleteWorkspace);
    on<SaveSpaceDetails>(_saveSpace);
  }

  void _init(EditSpaceInitialEvent event, Emitter<EditSpaceState> emit) async {}

  Space get space => _userManager.currentSpace!;

  void _onNameChange(
      CompanyNameChangeEvent event, Emitter<EditSpaceState> emit) {
    emit(state.copyWith(nameIsValid: event.companyName.isNotEmpty));
  }

  void _timeOffChange(
      YearlyPaidTimeOffChangeEvent event, Emitter<EditSpaceState> emit) {
    try {
      int.parse(event.timeOff);
      emit(state.copyWith(yearlyPaidTimeOffIsValid: true));
    } on Exception {
      emit(state.copyWith(yearlyPaidTimeOffIsValid: false));
    }
  }

  Future<void> _deleteWorkspace(
      DeleteSpaceEvent event, Emitter<EditSpaceState> emit) async {
    try {
      emit(state.copyWith(deleteWorkSpaceStatus: Status.loading));
      await _spaceService.deleteSpace(space.id, space.ownerIds);
      await _userManager.removeSpace();
      emit(state.copyWith(deleteWorkSpaceStatus: Status.success));
    } on Exception {
      emit(state.copyWith(deleteWorkSpaceStatus: Status.failure, error: somethingWentWrongError));
    }
  }

  Future<void> _saveSpace(
      SaveSpaceDetails event, Emitter<EditSpaceState> emit) async {
    try {
      emit(state.copyWith(updateSpaceStatus: Status.loading));
      final Space updatedSpace = Space(
        name: event.spaceName,
        domain: event.spaceDomain,
        paidTimeOff: int.parse(event.paidTimeOff),
        id: space.id,
        createdAt: space.createdAt,
        ownerIds: space.ownerIds,
        logo: space.logo,
      );
      await _spaceService.updateSpace(updatedSpace);
      await _userManager.updateSpaceDetails(updatedSpace);
      emit(state.copyWith(updateSpaceStatus: Status.success));
    } on Exception {
      emit(state.copyWith(updateSpaceStatus: Status.failure, error: somethingWentWrongError));
    }
  }
}
