import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/data/core/exception/error_const.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/data/services/space_service.dart';
import 'package:projectunity/ui/admin/setting/update_leave_count/bloc/admin_setting_update_leave_count_screen_bloc.dart';
import 'package:projectunity/ui/admin/setting/update_leave_count/bloc/admin_setting_update_leave_count_screen_event.dart';
import 'package:projectunity/ui/admin/setting/update_leave_count/bloc/admin_setting_update_leave_count_screen_state.dart';

import 'admin_setting_paid_leave_count_bloc_test.mocks.dart';

@GenerateMocks([SpaceService,UserManager])
void main() {
  late UserManager userManager;
  late SpaceService spaceService;
  late AdminSettingUpdatePaidLeaveCountBloc
      adminSettingUpdatePaidLeaveCountBloc;

  setUpAll(() {
    userManager = MockUserManager();
    spaceService = MockSpaceService();
    adminSettingUpdatePaidLeaveCountBloc =
        AdminSettingUpdatePaidLeaveCountBloc(spaceService,userManager);
  });

  group("admin setting paid leave count screen tests", () {
    test("initial load data test", () {
      when(userManager.currentSpaceId).thenReturn('space-id');
      when(spaceService.getPaidLeaves(spaceId: 'space-id'))
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
      when(userManager.currentSpaceId).thenReturn('space-id');
      when(spaceService.updateLeaveCount(spaceId: 'space-id',paidLeaveCount: 10)).thenThrow(Exception("error"));
      adminSettingUpdatePaidLeaveCountBloc
          .add(UpdatePaidLeaveCountEvent(leaveCount: "10"));
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
