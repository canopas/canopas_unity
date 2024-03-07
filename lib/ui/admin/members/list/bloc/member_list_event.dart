abstract class AdminMembersEvents {}

class AdminMembersInitialLoadEvent extends AdminMembersEvents {}

class CancelUserInvitation extends AdminMembersEvents {
  final String id;
  CancelUserInvitation(this.id);
}

class ExpansionChangeEvent extends AdminMembersEvents {
  final int id;
  ExpansionChangeEvent(this.id);
}
