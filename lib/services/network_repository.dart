import 'package:injectable/injectable.dart';
import 'package:projectunity/model/leave/leave_detail.dart';
import 'package:projectunity/services/leave/team_leaves_api_service.dart';
import 'package:projectunity/services/leave/user_leaves_api_service.dart';

@Injectable()
class NetworkRepository {
  final UserLeavesApiService _userLeavesApiService;
  final TeamLeavesApiService _teamLeavesApiService;

  NetworkRepository(this._userLeavesApiService, this._teamLeavesApiService);

  Future<LeaveDetail> getLeavesOfUserFromRepo() {
    return _userLeavesApiService.getUserLeaves();
  }

  Future<LeaveDetail> getTeamLeavesFromRepo() {
    return _teamLeavesApiService.getTeamLeaves();
  }
}
