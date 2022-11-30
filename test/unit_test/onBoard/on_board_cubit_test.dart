import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/pref/user_preference.dart';
import 'package:projectunity/ui/onboard/bloc/onboard_bloc.dart';
import 'package:projectunity/ui/onboard/bloc/onboard_event.dart';

import 'on_board_cubit_test.mocks.dart';

@GenerateMocks([UserPreference,NavigationStackManager])
void main(){

  late UserPreference preference;
  late NavigationStackManager navigationStackManager;
  late OnBoardBloc onBoardBloc;

  setUpAll(() {
    preference = MockUserPreference();
    navigationStackManager = MockNavigationStackManager();
    onBoardBloc = OnBoardBloc(preference, navigationStackManager);
  });

  group("On Board Test", () {
    test("current page change test", (){
      onBoardBloc.add(CurrentPageChangeEvent(page: 2));
      expect(onBoardBloc.stream, emits(2));
    });

    test("navigate to login screen test", () async {
      const state = LoginNavStackItem();
      onBoardBloc.add(SetOnBoardCompletedEvent());
      await untilCalled(navigationStackManager.clearAndPush(state));
      verify(navigationStackManager.clearAndPush(state)).called(1);
    });

  });
}