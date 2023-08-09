import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:projectunity/data/model/forms/form_response/form_response.dart';
import '../core/utils/const/firestore.dart';
import '../model/forms/form_field/form_field.dart';
import '../model/forms/form_info/form.dart';
import '../model/forms/forms.dart';

@Injectable()
class FormService {
  late final FirebaseFirestore fireStore;

  FormService(this.fireStore);

  CollectionReference<FormInfo> _formsDB({required String spaceId}) => fireStore
      .collection(FireStoreConst.spacesCollection)
      .doc(spaceId)
      .collection(FireStoreConst.formsCollection)
      .withConverter(
          fromFirestore: FormInfo.fromFireStore,
          toFirestore: (FormInfo form, _) => form.toJson());

  CollectionReference<FormField> _formsFieldDB(
          {required String spaceId, required String formId}) =>
      _formsDB(spaceId: spaceId)
          .doc(formId)
          .collection(FireStoreConst.formFieldsCollection)
          .withConverter(
              fromFirestore: FormField.fromFireStore,
              toFirestore: (FormField form, _) => form.toJson());

  CollectionReference<FormResponse> _formsResponseDB(
          {required String spaceId, required String formId}) =>
      _formsDB(spaceId: spaceId)
          .doc(formId)
          .collection(FireStoreConst.formResponseCollection)
          .withConverter(
              fromFirestore: FormResponse.fromFireStore,
              toFirestore: (FormResponse formResponse, _) =>
                  formResponse.toJson());

  String generateNewFormId({required String spaceId}) =>
      _formsDB(spaceId: spaceId).doc().id;

  String generateNewFormFieldId(
          {required String formId, required String spaceId}) =>
      _formsFieldDB(spaceId: spaceId, formId: formId).doc().id;

  Future<void> createForm(
      {required FormInfo form,
      required List<FormField> fields,
      required String spaceId}) async {
    await _formsDB(spaceId: spaceId).doc(form.id).set(form);

    for (FormField field in fields) {
      await _formsFieldDB(spaceId: spaceId, formId: form.id)
          .doc(field.id)
          .set(field);
    }
  }

  Future<List<FormInfo>> getForms({required String spaceId}) async {
    final formsSnapshot = await _formsDB(spaceId: spaceId).get();
    return formsSnapshot.docs.map((formDoc) => formDoc.data()).toList();
  }

  Future<Form?> getForm(
      {required String spaceId, required String formId}) async {
    final formInfoSnapshot = await _formsDB(spaceId: spaceId).doc(formId).get();
    final fieldsSnapshot =
        await _formsFieldDB(spaceId: spaceId, formId: formId).get();
    final List<FormField> fields =
        fieldsSnapshot.docs.map((e) => e.data()).toList();

    if (formInfoSnapshot.exists && fields.isNotEmpty) {
      return Form(formInfo: formInfoSnapshot.data()!, fields: fields);
    }
    return null;
  }

  Future<List<FormResponse>> getFormResponse(
      {required String spaceId, required String formId}) async {
    final formResponseSnapshot = await _formsResponseDB(spaceId: spaceId, formId: formId).get();
    return formResponseSnapshot.docs.map((e) => e.data()).toList();
  }
}
