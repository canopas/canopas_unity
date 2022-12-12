import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/ui/admin/setting/bloc/admin_setting_screen_bloc.dart';
import 'package:projectunity/ui/admin/setting/bloc/admin_setting_screen_event.dart';

import 'admin_setting_test.mocks.dart';


@GenerateMocks([NavigationStackManager])
void main(){
  group("Admin Setting Bloc Test", () {
    late AdminSettingScreenBLoc adminSettingScreenBLoc;
    late NavigationStackManager stackManager;
    setUpAll((){
      stackManager = MockNavigationStackManager();
      adminSettingScreenBLoc = AdminSettingScreenBLoc(stackManager);
    });
    test('Navigate to Setting screen on AdminHomeNavigateToSetting event',
            () async {
          const state = NavStackItem.paidLeaveSettingsState();
          adminSettingScreenBLoc.add(NavigateToPaidLeaveCountEvent());
          await untilCalled(stackManager.push(state));
          verify(stackManager.push(state)).called(1);
        });
  });
}