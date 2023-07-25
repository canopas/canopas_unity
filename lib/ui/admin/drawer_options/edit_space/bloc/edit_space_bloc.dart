import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import 'package:projectunity/data/core/mixin/input_validation.dart';
import 'package:projectunity/data/services/space_service.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/model/space/space.dart';
import '../../../../../data/provider/user_status_notifier.dart';
import '../../../../../data/services/storage_service.dart';
import 'edit_space_state.dart';
import 'edit_space_event.dart';

@Injectable()
class EditSpaceBloc extends Bloc<EditSpaceEvent, EditSpaceState>
    with InputValidationMixin {
  final UserStatusNotifier _userStateNotifier;
  final SpaceService _spaceService;
  final ImagePicker imagePicker;
  final StorageService storageService;

  EditSpaceBloc(this._spaceService, this._userStateNotifier, this.imagePicker,
      this.storageService)
      : super(const EditSpaceState()) {
    on<EditSpaceInitialEvent>(_init);

    on<CompanyNameChangeEvent>(_onNameChangeValidation);
    on<YearlyPaidTimeOffChangeEvent>(_timeOffChangeValidation);
    on<NotificationEmailChangeEvent>(_notificationEmailChangeValidation);
    on<DeleteSpaceEvent>(_deleteSpace);
    on<SaveSpaceDetails>(_saveSpace);
    on<PickImageEvent>(_pickImage);
  }

  void _init(EditSpaceInitialEvent event, Emitter<EditSpaceState> emit) async {}

  void _onNameChangeValidation(
      CompanyNameChangeEvent event, Emitter<EditSpaceState> emit) {
    emit(state.copyWith(nameIsValid: validInputLength(event.companyName)));
  }

  void _notificationEmailChangeValidation(
      NotificationEmailChangeEvent event, Emitter<EditSpaceState> emit) {
    emit(state.copyWith(
        nameIsValid: event.notificationEmail.trim().isEmpty ||
            validEmail(event.notificationEmail)));
  }

  void _timeOffChangeValidation(
      YearlyPaidTimeOffChangeEvent event, Emitter<EditSpaceState> emit) {
    try {
      int.parse(event.timeOff);
      emit(state.copyWith(yearlyPaidTimeOffIsValid: true));
    } on Exception {
      emit(state.copyWith(yearlyPaidTimeOffIsValid: false));
    }
  }

  Future<void> _deleteSpace(
      DeleteSpaceEvent event, Emitter<EditSpaceState> emit) async {
    emit(state.copyWith(deleteWorkSpaceStatus: Status.loading));
    try {
      await _spaceService.deleteSpace(
         spaceId:  _userStateNotifier.currentSpace!.id, owners: _userStateNotifier.currentSpace!.ownerIds,uid: _userStateNotifier.employeeId);
      await _userStateNotifier.removeEmployeeWithSpace();
      emit(state.copyWith(deleteWorkSpaceStatus: Status.success));
    } on Exception {
      emit(state.copyWith(
          deleteWorkSpaceStatus: Status.error, error: firestoreFetchDataError));
    }
  }

  Future<void> _pickImage(
      PickImageEvent event, Emitter<EditSpaceState> emit) async {
    final XFile? image = await imagePicker.pickImage(source: event.imageSource);
    if (image != null) {
      emit(state.copyWith(logo: image.path, isLogoPickedDone: true));
    }
  }

  Future<void> _saveSpace(
      SaveSpaceDetails event, Emitter<EditSpaceState> emit) async {
    emit(state.copyWith(updateSpaceStatus: Status.loading));
    try {
      final space = _userStateNotifier.currentSpace!;

      String? logoURL = space.logo;

      if (state.logo.isNotNullOrEmpty) {
        final String storagePath =
            'images/${_userStateNotifier.currentSpaceId}/space-logo';
        logoURL = await storageService.uploadProfilePic(
            path: storagePath, imagePath: state.logo!);
      }

      final Space updatedSpace = Space(
        notificationEmail: event.notificationEmail.trim().isEmpty
            ? null
            : event.notificationEmail,
        name: event.spaceName,
        domain: event.spaceDomain,
        paidTimeOff: int.parse(event.paidTimeOff),
        id: space.id,
        createdAt: space.createdAt,
        ownerIds: space.ownerIds,
        logo: logoURL,
      );
      await _spaceService.updateSpace(updatedSpace);
      await _userStateNotifier.updateSpace(updatedSpace);
      emit(state.copyWith(updateSpaceStatus: Status.success));
    } on Exception {
      emit(state.copyWith(
          updateSpaceStatus: Status.error, error: firestoreFetchDataError));
    }
  }
}
