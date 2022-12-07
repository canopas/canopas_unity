import 'package:flutter_test/flutter_test.dart';
import 'package:projectunity/ui/admin/setting/update_leave_count/bloc/admin_setting_update_paid_leave_button_state_bloc.dart';
import 'package:projectunity/ui/admin/setting/update_leave_count/bloc/admin_setting_update_paid_leave_button_state_event.dart';

void main() {
  late AdminPaidLeaveUpdateSettingTextFieldBloc
      adminPaidLeaveUpdateSettingTextFieldBloc;

  setUpAll(() {
    adminPaidLeaveUpdateSettingTextFieldBloc =
        AdminPaidLeaveUpdateSettingTextFieldBloc();
  });

  group("admin setting leave count screen cubit value change test", () {
    test("initial load data test", () {
      adminPaidLeaveUpdateSettingTextFieldBloc.add(PaidLeaveTextFieldChangeValueEvent(value: "12"));
      expect(adminPaidLeaveUpdateSettingTextFieldBloc.stream, emits("12"));
    });
  });
}
