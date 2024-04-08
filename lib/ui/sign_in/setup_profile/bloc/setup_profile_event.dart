abstract class SetUpProfileEvent {}

class NameChangedEvent extends SetUpProfileEvent {
  final String name;
  NameChangedEvent({required this.name});
}

class EmailChangedEvent extends SetUpProfileEvent {
  final String email;
  EmailChangedEvent({required this.email});
}

class SubmitProfileEvent extends SetUpProfileEvent {
  final String uid;
  SubmitProfileEvent({required this.uid});
}
