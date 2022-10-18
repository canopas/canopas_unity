import 'package:injectable/injectable.dart';
import 'package:projectunity/base_bloc.dart';
import 'package:projectunity/navigation/nav_stack/nav_stack_item.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/pref/user_preference.dart';

@Injectable()
class OnBoardBloc extends BaseBLoc {
  final UserPreference _preference;
  final NavigationStackManager _navigationStackManager;

  OnBoardBloc(this._preference, this._navigationStackManager);

  void setOnBoardCompleted() {
    _preference.setOnBoardCompleted(true);
    _navigationStackManager.clearAndPush(const LoginNavStackItem());
  }

  @override
  void attach() {}

  @override
  void detach() {}
}
