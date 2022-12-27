import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/pref/user_preference.dart';
import 'package:projectunity/provider/user_data.dart';
import 'package:projectunity/ui/onboard/bloc/onboard_bloc.dart';
import 'package:projectunity/ui/onboard/bloc/onboard_event.dart';

import '../admin/leave_details/admin_leave_details_bloc_test.mocks.dart';
import 'on_board_cubit_test.mocks.dart';
@GenerateMocks([UserPreference])
void main(){

  late UserPreference preference;
  late OnBoardBloc onBoardBloc;
  late UserManager userManager;

  setUpAll(() {
    preference = MockUserPreference();
    userManager= MockUserManager();

    onBoardBloc = OnBoardBloc(preference,userManager);
  });

  group("On Board Test", () {
    test("current page change test", (){
      onBoardBloc.add(CurrentPageChangeEvent(page: 2));
      expect(onBoardBloc.stream, emits(2));
    });

    test("navigate to login screen test", () async {
      onBoardBloc.add(SetOnBoardCompletedEvent());
      await untilCalled(userManager.hasOnBoarded());
      verify(userManager.hasOnBoarded()).called(1);
    });

  });
}