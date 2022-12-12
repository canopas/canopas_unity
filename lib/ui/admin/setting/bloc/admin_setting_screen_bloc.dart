import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/navigation/navigation_stack_manager.dart';
import 'package:projectunity/ui/admin/setting/bloc/admin_setting_screen_state.dart';

import '../../../../navigation/nav_stack/nav_stack_item.dart';
import 'admin_setting_screen_event.dart';

@Injectable()
class AdminSettingScreenBLoc extends Bloc<AdminSettingScreenEvent,AdminSettingScreenState>{
  final NavigationStackManager _stateManager;
  AdminSettingScreenBLoc(this._stateManager) : super(AdminSettingScreenState()){
    on<NavigateToPaidLeaveCountEvent>(_navigateToPaidLeaveCount);
  }

  void _navigateToPaidLeaveCount(NavigateToPaidLeaveCountEvent event, Emitter<AdminSettingScreenState> emit){
    _stateManager.push(const NavStackItem.paidLeaveSettingsState());
  }
}