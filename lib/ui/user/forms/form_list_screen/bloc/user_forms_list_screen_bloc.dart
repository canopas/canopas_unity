import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/ui/user/forms/form_list_screen/bloc/user_forms_list_screen_event.dart';
import 'package:projectunity/ui/user/forms/form_list_screen/bloc/user_forms_list_screen_state.dart';
import '../../../../../data/core/exception/error_const.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/repo/form_repo.dart';

@Injectable()
class UserFormListBloc extends Bloc<UserFormListEvents, UserFormListState> {
  final FormRepo _formRepo;

  UserFormListBloc(this._formRepo) : super(const UserFormListState()) {
    on<UserFormListInitialLoadEvent>(_init);
  }

  Future<void> _init(
    UserFormListInitialLoadEvent event,
    Emitter<UserFormListState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final forms = await _formRepo.getForms();
      emit(state.copyWith(status: Status.success, forms: forms));
    } on Exception {
      emit(
        state.copyWith(status: Status.error, error: firestoreFetchDataError),
      );
    }
  }
}
