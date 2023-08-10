import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../core/utils/const/firestore.dart';
import '../model/org_forms/org_form_field/org_form_field.dart';
import '../model/org_forms/org_form_info/org_form_info.dart';
import '../model/org_forms/org_form_response/org_form_response.dart';
import '../model/org_forms/org_forms.dart';


@Injectable()
class FormService {
  late final FirebaseFirestore fireStore;

  FormService(this.fireStore);

  CollectionReference<OrgFormInfo> _formsDB({required String spaceId}) =>
      fireStore
          .collection(FireStoreConst.spacesCollection)
          .doc(spaceId)
          .collection(FireStoreConst.formsCollection)
          .withConverter(
              fromFirestore: OrgFormInfo.fromFireStore,
              toFirestore: (OrgFormInfo form, _) => form.toJson());

  CollectionReference<OrgFormField> _formsFieldDB(
          {required String spaceId, required String formId}) =>
      _formsDB(spaceId: spaceId)
          .doc(formId)
          .collection(FireStoreConst.formFieldsCollection)
          .withConverter(
              fromFirestore: OrgFormField.fromFireStore,
              toFirestore: (OrgFormField form, _) => form.toJson());

  CollectionReference<OrgFormResponse> _formsResponseDB(
          {required String spaceId, required String formId}) =>
      _formsDB(spaceId: spaceId)
          .doc(formId)
          .collection(FireStoreConst.formResponseCollection)
          .withConverter(
              fromFirestore: OrgFormResponse.fromFireStore,
              toFirestore: (OrgFormResponse formResponse, _) =>
                  formResponse.toJson());

  String generateNewFormId({required String spaceId}) =>
      _formsDB(spaceId: spaceId).doc().id;

  String generateNewFormFieldId(
          {required String formId, required String spaceId}) =>
      _formsFieldDB(spaceId: spaceId, formId: formId).doc().id;

  Future<void> createForm(
      {required OrgFormInfo form,
      required List<OrgFormField> fields,
      required String spaceId}) async {
    await _formsDB(spaceId: spaceId).doc(form.id).set(form);

    for (OrgFormField field in fields) {
      await _formsFieldDB(spaceId: spaceId, formId: form.id)
          .doc(field.id)
          .set(field);
    }
  }

  Future<List<OrgFormInfo>> getForms({required String spaceId}) async {
    final formsSnapshot = await _formsDB(spaceId: spaceId).get();
    return formsSnapshot.docs.map((formDoc) => formDoc.data()).toList();
  }

  Future<OrgForm?> getForm(
      {required String spaceId, required String formId}) async {
    final formInfoSnapshot = await _formsDB(spaceId: spaceId).doc(formId).get();
    final fieldsSnapshot =
        await _formsFieldDB(spaceId: spaceId, formId: formId).get();
    final List<OrgFormField> fields =
        fieldsSnapshot.docs.map((e) => e.data()).toList();

    if (formInfoSnapshot.exists && fields.isNotEmpty) {
      return OrgForm(formInfo: formInfoSnapshot.data()!, fields: fields);
    }
    return null;
  }

  Future<List<OrgFormResponse>> getFormResponse(
      {required String spaceId, required String formId}) async {
    final formResponseSnapshot =
        await _formsResponseDB(spaceId: spaceId, formId: formId).get();
    return formResponseSnapshot.docs.map((e) => e.data()).toList();
  }
}
