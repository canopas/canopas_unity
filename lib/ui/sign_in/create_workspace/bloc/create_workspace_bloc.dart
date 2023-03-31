import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/model/space/space.dart';

import '../../../../data/provider/user_data.dart';
import '../../../../data/services/space_service.dart';
import 'create_workspace_event.dart';
import 'create_workspace_state.dart';

@Injectable()
class CreateSpaceBLoc extends Bloc<CreateSpaceEvent, CreateSpaceState> {
  final SpaceService _spaceService;
  final UserManager _userManager;
  CreateSpaceBLoc(this._spaceService, this._userManager)
      : super(const CreateSpaceState()) {
    on<PageChangeEvent>(_onPageChange);
    on<CompanyNameChangeEvent>(_onNameChanged);
    on<CompanyDomainChangeEvent>(_onDomainChanged);
    on<PaidTimeOffChangeEvent>(_onTimeOffChanged);
    on<CreateSpaceButtonTapEvent>(_createSpace);
  }

  bool validName(String? name) => name != null && name.length >= 4;

  bool validEmail(String? email) =>
      email != null && email.length >= 4 && email.contains('@');

  void _onPageChange(PageChangeEvent event, Emitter<CreateSpaceState> emit) {
    emit(state.copyWith(page: event.page));
  }

  void _onNameChanged(
      CompanyNameChangeEvent event, Emitter<CreateSpaceState> emit) {
    if (validName(event.name)) {
      emit(state.copyWith(
          name: event.name,
          nameError: false,
          nextButtonStatus: ButtonStatus.enable));
    } else {
      emit(state.copyWith(
          name: event.name,
          nameError: true,
          nextButtonStatus: ButtonStatus.disable));
    }
  }

  void _onDomainChanged(
      CompanyDomainChangeEvent event, Emitter<CreateSpaceState> emit) {
    if (validEmail(event.domain)) {
      emit(state.copyWith(domain: event.domain, domainError: false));
    } else {
      emit(state.copyWith(domain: event.domain, domainError: true));
    }
  }

  void _onTimeOffChanged(
      PaidTimeOffChangeEvent event, Emitter<CreateSpaceState> emit) {
    if (event.paidTimeOff == '') {
      emit(state.copyWith(
          paidTimeOff: event.paidTimeOff,
          paidTimeOffError: true,
          createSpaceButtonStatus: ButtonStatus.disable));
    } else {
      emit(state.copyWith(
          paidTimeOff: event.paidTimeOff,
          paidTimeOffError: false,
          createSpaceButtonStatus: ButtonStatus.enable));
    }
  }

  bool get validateSpaceData =>
      validName(state.name) &&
      validEmail(state.domain) &&
      !state.nameError &&
      !state.domainError;

  Future<void> _createSpace(
      CreateSpaceButtonTapEvent event, Emitter<CreateSpaceState> emit) async {
    if (!validateSpaceData) {
      emit(state.copyWith(error: provideRequiredInformation));
    } else {
      emit(state.copyWith(createSpaceStatus: CreateSpaceStatus.loading));
      try {
        int timeOff = int.parse(state.paidTimeOff);
        final spaceData = Space(
          name: state.name,
          createdAt: DateTime.now(),
          paidTimeOff: timeOff,
          ownerIds: [_userManager.email],
        );
        await _spaceService.createSpace(spaceData);
        emit(state.copyWith(createSpaceStatus: CreateSpaceStatus.success));
      } on Exception {
        emit(state.copyWith(
            error: firestoreFetchDataError,
            createSpaceStatus: CreateSpaceStatus.error));
      }
    }
  }
}
