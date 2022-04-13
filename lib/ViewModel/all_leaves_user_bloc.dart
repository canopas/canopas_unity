import 'package:injectable/injectable.dart';
import 'package:projectunity/model/Leave/leave_detail.dart';
import 'package:projectunity/rest/api_response.dart';
import 'package:projectunity/services/network_repository.dart';
import 'package:rxdart/rxdart.dart';

@Singleton()
class AllLeavesUserBloc {
  final NetworkRepository _networkRepository;

  AllLeavesUserBloc(this._networkRepository);

  final _allLeaves = BehaviorSubject<ApiResponse<LeaveDetail>>();

  BehaviorSubject<ApiResponse<LeaveDetail>> get allLeavesOfUser => _allLeaves;

  getAllLeaves() async {
    _allLeaves.sink.add(const ApiResponse.loading());
    try {
      LeaveDetail leaveDetail =
          await _networkRepository.getLeavesOfUserFromRepo();
      _allLeaves.sink.add(ApiResponse.completed(data: leaveDetail));
    } on Exception catch (error) {
      _allLeaves.sink.add(ApiResponse.error(message: error.toString()));
    }
  }

  void dispose() {
    _allLeaves.close();
  }
}
