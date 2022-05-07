import 'app_state.dart';

class ScreenState {
  AppState appState;
  int id;

  ScreenState({
    required this.appState,
    required this.id,
  });
}

ScreenState homeScreenState =
    ScreenState(appState: const AppState.homeState(), id: 0);
ScreenState leaveScreenState =
    ScreenState(appState: const AppState.leaveState(), id: 1);
ScreenState userAllLeavesScreenState =
    ScreenState(appState: const AppState.userAllLeaveState(), id: 1);
ScreenState userUpComingLeavesScreenState =
    ScreenState(appState: const AppState.userUpcomingLeaveState(), id: 1);
ScreenState teamLeavesScreenState =
    ScreenState(appState: const AppState.teamLeavesState(), id: 1);
ScreenState leaveRequestScreenState =
    ScreenState(appState: const AppState.leaveRequestState(), id: 1);
ScreenState settingScreenState =
    ScreenState(appState: const AppState.settingsState(), id: 2);
