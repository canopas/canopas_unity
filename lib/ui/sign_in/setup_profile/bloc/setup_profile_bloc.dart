import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/model/account/account.dart';
import 'package:projectunity/data/services/account_service.dart';
import 'package:projectunity/ui/sign_in/setup_profile/bloc/setup_profile_event.dart';
import 'package:projectunity/ui/sign_in/setup_profile/bloc/setup_profile_state.dart';

import '../../../../data/core/mixin/input_validation.dart';
import '../../../../data/provider/user_state.dart';

@Injectable()
class SetupProfileBloc extends Bloc<SetUpProfileEvent, SetupProfileState>
    with InputValidationMixin {
  final AccountService _accountService;
  final UserStateNotifier _userStateNotifier;
  SetupProfileBloc(this._accountService, this._userStateNotifier)
    : super(const SetupProfileState()) {
    on<NameChangedEvent>(_validName);
    on<EmailChangedEvent>(_validEmail);
    on<SubmitProfileEvent>(_onSubmitProfile);
  }

  void _validName(NameChangedEvent event, Emitter<SetupProfileState> emit) {
    if (validInputLength(event.name)) {
      emit(state.copyWith(nameError: false));
      if (!state.emailError) {
        emit(state.copyWith(buttonEnabled: true));
      }
    } else {
      emit(state.copyWith(nameError: true, buttonEnabled: false));
    }
  }

  void _validEmail(EmailChangedEvent event, Emitter<SetupProfileState> emit) {
    if (validEmail(event.email)) {
      emit(state.copyWith(emailError: false));
      if (!state.emailError) {
        emit(state.copyWith(buttonEnabled: true));
      }
    } else {
      emit(state.copyWith(emailError: true, buttonEnabled: false));
    }
  }

  void _onSubmitProfile(
    SubmitProfileEvent event,
    Emitter<SetupProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(isSubmitting: true));
      final user = Account(
        uid: event.uid,
        email: state.email,
        name: state.name,
      );

      await _accountService.setUserAccount(user);
      await _userStateNotifier.setUser(user);
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (error, stackTrace) {
      FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
        reason: "Error setting up profile",
      );
      emit(state.copyWith(isSubmitting: false, error: error.toString()));
    }
  }
}
