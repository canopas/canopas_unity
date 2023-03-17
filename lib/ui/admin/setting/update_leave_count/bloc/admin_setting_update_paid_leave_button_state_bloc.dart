import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'admin_setting_update_paid_leave_button_state_event.dart';

@Injectable()
class AdminPaidLeaveUpdateSettingTextFieldBloc
    extends Bloc<AdminPaidLeaveUpdateSettingTextFieldEvent, String> {
  AdminPaidLeaveUpdateSettingTextFieldBloc() : super("") {
    on<PaidLeaveTextFieldChangeValueEvent>(_changeValue);
  }

  void _changeValue(
      PaidLeaveTextFieldChangeValueEvent event, Emitter<String> emit) {
    emit(event.value);
  }
}
