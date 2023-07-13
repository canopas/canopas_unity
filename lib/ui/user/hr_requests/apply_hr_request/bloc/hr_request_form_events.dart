import '../../../../../data/model/hr_request/hr_request.dart';

abstract class HrRequestFormEvents {}

class ChangeType extends HrRequestFormEvents {
  final HrRequestType? type;

  ChangeType(this.type);
}

class ChangeDescription extends HrRequestFormEvents {
  final String description;

  ChangeDescription(this.description);
}

class ApplyHrRequest extends HrRequestFormEvents {}
