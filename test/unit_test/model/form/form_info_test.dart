import 'package:flutter_test/flutter_test.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/model/org_forms/org_form_info/org_form_info.dart';

void main() {
  group("Form Info", () {
    group('from json and from firestore', () {
      test('returns correct Form Info object ', () {
        expect(
            OrgFormInfo.fromJson(<String, dynamic>{
              'id': 'id',
              'title': 'title',
              'description': 'description',
              'image': 'image-url',
              'one_time_response': false,
              'created_at': DateTime(2023).timeStampToInt
            }),
            isA<OrgFormInfo>()
                .having((info) => info.id, 'Unique form id', 'id')
                .having((info) => info.title, 'form title', 'title')
                .having((info) => info.description, 'form description',
                    'description')
                .having((info) => info.image, 'Form header url', 'image-url')
                .having((info) => info.createdAt, 'Form create time',
                    DateTime(2023))
                .having((info) => info.oneTimeResponse,
                    'Is user able to fill form multiple time', false));
      });
    });

    test('apply correct formInfo to firestore', () {
      OrgFormInfo info = OrgFormInfo(
          createdAt: DateTime(2023),
          id: 'id',
          title: 'title',
          description: 'description',
          image: 'image-url',
          oneTimeResponse: false);
      Map<String, dynamic> map = <String, dynamic>{
        'created_at': DateTime(2023).timeStampToInt,
        'id': 'id',
        'title': 'title',
        'description': 'description',
        'image': 'image-url',
        'one_time_response': false,
      };

      expect(info.toJson(), map);
    });
  });
}
