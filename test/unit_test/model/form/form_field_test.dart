import 'package:flutter_test/flutter_test.dart';
import 'package:projectunity/data/model/org_forms/org_form_field/org_form_field.dart';

void main() {
  group("Form Field", () {
    group('from json and from firestore', () {
      test('returns correct Form field object ', () {
        expect(
          OrgFormField.fromJson(const <String, dynamic>{
            'id': 'id',
            'index': 1,
            'question': 'question',
            'type': 0,
            'answer_type': 0,
            'options': ['option 1', 'option 2'],
            'is_required': false,
          }),
          isA<OrgFormField>()
              .having((info) => info.id, 'Unique form field id', 'id')
              .having((info) => info.index, 'form field index', 1)
              .having(
                (info) => info.question,
                'form field question',
                'question',
              )
              .having((info) => info.options, 'form field option', [
                'option 1',
                'option 2',
              ])
              .having((info) => info.isRequired, 'form field is require', false)
              .having((info) => info.type, 'Form type', FormFieldType.text)
              .having(
                (info) => info.answerType,
                'Form answer type',
                FormFieldAnswerType.text,
              ),
        );
      });
    });

    test('apply correct form field to firestore', () {
      OrgFormField field = const OrgFormField(
        id: 'id',
        question: 'question',
        index: 1,
        options: ['option 1', 'option 2'],
        answerType: FormFieldAnswerType.text,
        type: FormFieldType.text,
        isRequired: false,
      );
      Map<String, dynamic> map = const <String, dynamic>{
        'id': 'id',
        'index': 1,
        'question': 'question',
        'type': 0,
        'answer_type': 0,
        'options': ['option 1', 'option 2'],
        'is_required': false,
      };

      expect(field.toJson(), map);
    });
  });
}
