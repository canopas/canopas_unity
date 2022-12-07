import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/services/admin/paid_leave/paid_leave_service.dart';
import 'package:projectunity/ui/admin/setting/update_leave_count/bloc/admin_setting_update_leave_count_screen_bloc.dart';
import 'package:projectunity/ui/admin/setting/update_leave_count/bloc/admin_setting_update_leave_count_screen_event.dart';
import 'package:projectunity/ui/admin/setting/update_leave_count/bloc/admin_setting_update_leave_count_screen_state.dart';

import 'admin_setting_paid_leave_count_bloc_test.mocks.dart';

@GenerateMocks([PaidLeaveService, NavigationStackManager])
void main() {
  late PaidLeaveService paidLeaveService;
  late NavigationStackManager stateManager;
  late AdminSettingUpdatePaidLeaveCountBloc
      adminSettingUpdatePaidLeaveCountBloc;

  setUpAll(() {
    paidLeaveService = MockPaidLeaveService();
    stateManager = MockNavigationStackManager();
    adminSettingUpdatePaidLeaveCountBloc =
        AdminSettingUpdatePaidLeaveCountBloc(paidLeaveService, stateManager);
  });

  group("admin setting paid leave count screen tests", () {
    test("initial load data test", () {
      when(paidLeaveService.getPaidLeaves())
          .thenAnswer((_) => Future(() => 12));
      adminSettingUpdatePaidLeaveCountBloc
          .add(AdminSettingPaidLeaveCountInitialLoadEvent());
      expect(
          adminSettingUpdatePaidLeaveCountBloc.stream,
          emitsInOrder([
            AdminSettingUpdateLeaveCountLoadingState(),
            AdminSettingUpdateLeaveCountSuccessState(paidLeaveCount: 12)
          ]));
    });

    test("check error on update leave count test", () {
      when(paidLeaveService.updateLeaveCount(10)).thenThrow(Exception("error"));
      adminSettingUpdatePaidLeaveCountBloc.add(UpdatePaidLeaveCountEvent(leaveCount: "10"));
      expect(
          adminSettingUpdatePaidLeaveCountBloc.stream,
          emitsInOrder([
            AdminSettingUpdateLeaveCountLoadingState(),
            AdminSettingUpdateLeaveCountFailureState(
                error: firestoreFetchDataError)
          ]));
    });
  });
}
