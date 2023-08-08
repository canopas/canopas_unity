import 'package:injectable/injectable.dart';

@Injectable()
class AppFunctions {
  bool isUrgentLeave(
      {required DateTime startDate,
      required DateTime appliedOn,
      required double totalLeaves}) {
    Duration diff = startDate.difference(appliedOn);
    if (totalLeaves <= 1 && diff.inDays >= 2) {
      return false;
    } else if (totalLeaves <= 3 && diff.inDays >= 7) {
      return false;
    } else if (totalLeaves <= 5 && diff.inDays >= 14) {
      return false;
    } else if (totalLeaves > 5 && diff.inDays >= 21) {
      return false;
    } else {
      return true;
    }
  }
}
