import 'package:equatable/equatable.dart';
import 'package:projectunity/model/leave_application.dart';


abstract class AdminHomeEvent extends Equatable{
  @override
  List<Object?> get props => [];
}


class AdminHomeInitialLoadEvent extends AdminHomeEvent{}
class AdminHomeNavigateToAddMember extends AdminHomeEvent{}
class AdminHomeNavigateToSetting extends AdminHomeEvent{}
class AdminHomeNavigateToEmployeeList extends AdminHomeEvent{}
class AdminHomeNavigateToAbsenceList extends AdminHomeEvent{}
class AdminHomeNavigateToApplicationDetail extends AdminHomeEvent{
 final LeaveApplication leaveApplication;
  AdminHomeNavigateToApplicationDetail(this.leaveApplication);
}





