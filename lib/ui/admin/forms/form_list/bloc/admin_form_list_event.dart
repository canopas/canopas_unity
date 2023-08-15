abstract class AdminFormListEvents {}

class AdminFormListInitialLoadEvent extends AdminFormListEvents {}

class UpdateFormEvent extends AdminFormListEvents {
  final String formId;
  UpdateFormEvent(this.formId);
}
