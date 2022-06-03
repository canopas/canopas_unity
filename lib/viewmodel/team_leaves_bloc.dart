import 'package:injectable/injectable.dart';
import 'package:projectunity/model/leave/leave_detail.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/services/network_repository.dart';
import 'package:rxdart/rxdart.dart';

@Singleton()
class TeamLeavesBloc {
  final NetworkRepository _networkRepository;

  TeamLeavesBloc(this._networkRepository);

  final _allLeaves = BehaviorSubject<ApiResponse<LeaveDetail>>();

  Stream<ApiResponse<LeaveDetail>> get allTeamLeaves => _allLeaves.stream;

  getTeamLeaves() async {
    _allLeaves.sink.add(const ApiResponse.loading());
    try {
      LeaveDetail leaveDetail =
          await _networkRepository.getTeamLeavesFromRepo();
      _allLeaves.sink.add(ApiResponse.completed(data: leaveDetail));
    } on Exception catch (error) {
      _allLeaves.sink.add(ApiResponse.error(message: error.toString()));
    }
  }

  void dispose() {
    _allLeaves.close();
  }
}
