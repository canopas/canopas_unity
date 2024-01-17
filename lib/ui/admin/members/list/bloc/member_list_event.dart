abstract class AdminMembersEvents {}

class AdminMembersInitialLoadEvent extends AdminMembersEvents {}

class CancelUserInvitation extends AdminMembersEvents {
  final String id;
  CancelUserInvitation(this.id);
}
