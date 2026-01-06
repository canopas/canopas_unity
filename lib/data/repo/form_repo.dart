import 'package:injectable/injectable.dart';
import '../model/org_forms/org_form_info/org_form_info.dart';
import '../model/org_forms/org_form_response/org_form_response.dart';
import '../model/org_forms/org_forms.dart';
import '../provider/user_state.dart';
import '../services/form_service.dart';

@Injectable()
class FormRepo {
  final UserStateNotifier _userStateNotifier;
  final FormService _formService;

  FormRepo(this._userStateNotifier, this._formService);

  String generateNewFormId() => _formService.generateNewFormId(
    spaceId: _userStateNotifier.currentSpaceId!,
  );

  String generateNewFormFieldId({required String formId}) =>
      _formService.generateNewFormFieldId(
        spaceId: _userStateNotifier.currentSpaceId!,
        formId: formId,
      );

  Future<void> createForm({required OrgForm orgForm}) async =>
      await _formService.createForm(
        form: orgForm,
        spaceId: _userStateNotifier.currentSpaceId!,
      );

  Future<List<OrgFormInfo>> getForms() async =>
      await _formService.getForms(spaceId: _userStateNotifier.currentSpaceId!);

  Future<OrgFormInfo?> getFormInfo({required String formId}) async =>
      await _formService.getFormInfo(
        spaceId: _userStateNotifier.currentSpaceId!,
        formId: formId,
      );

  Future<OrgForm?> getForm({required String formId}) async => await _formService
      .getForm(spaceId: _userStateNotifier.currentSpaceId!, formId: formId);

  Future<List<OrgFormResponse>> getFormResponse({
    required String formId,
  }) async => await _formService.getFormResponse(
    spaceId: _userStateNotifier.currentSpaceId!,
    formId: formId,
  );
}
