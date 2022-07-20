import 'package:injectable/injectable.dart';
import 'package:projectunity/services/leave/user_leave_service.dart';

@Injectable()
class AdminLeaveService {
  Future<void> updateLeaveStatus(String id, Map<String, dynamic> map) async {
    await leaveCollection.doc(id).update(map);
  }
}
