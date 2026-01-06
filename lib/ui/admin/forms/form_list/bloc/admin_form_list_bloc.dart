import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/core/extensions/list.dart';
import 'package:projectunity/data/model/org_forms/org_form_info/org_form_info.dart';
import 'package:projectunity/ui/admin/forms/form_list/bloc/admin_form_list_event.dart';
import 'package:projectunity/ui/admin/forms/form_list/bloc/admin_form_list_state.dart';
import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/repo/form_repo.dart';

@Injectable()
class AdminFormListBloc extends Bloc<AdminFormListEvents, AdminFormListState> {
  final FormRepo _formRepo;

  AdminFormListBloc(this._formRepo) : super(const AdminFormListState()) {
    on<AdminFormListInitialLoadEvent>(_init);
    on<UpdateFormEvent>(_updateForm);
  }

  Future<void> _init(
    AdminFormListInitialLoadEvent event,
    Emitter<AdminFormListState> emit,
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

  Future<void> _updateForm(
    UpdateFormEvent event,
    Emitter<AdminFormListState> emit,
  ) async {
    try {
      List<OrgFormInfo> forms = state.forms.toList();
      final form = await _formRepo.getFormInfo(formId: event.formId);
      forms.removeWhereAndAdd(form, (existForm) => existForm.id == form?.id);
      forms.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      emit(state.copyWith(status: Status.success, forms: forms));
    } on Exception {
      emit(
        state.copyWith(status: Status.error, error: firestoreFetchDataError),
      );
    }
  }
}
