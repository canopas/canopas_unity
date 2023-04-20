import 'package:flutter_test/flutter_test.dart';
import 'package:projectunity/data/model/space/space.dart';

void main() {
  group("User", () {
    test('Test returns correct Employee object from json and from fire-store',
        () {
      expect(
          Space.fromJson(<String, dynamic>{
            'id': "unique-space-id",
            'name': "dummy space",
            'created_at': DateTime(2023).millisecondsSinceEpoch,
            'logo': "space-logo-url",
            'owner_ids': ['uid'],
            'paid_time_off': 12,
            'domain': 'website-url',
          }),
          isA<Space>()
              .having((space) => space.id, 'unique space id', "unique-space-id")
              .having((space) => space.name, 'space name', "dummy space")
              .having((space) => space.createdAt, 'space create time',
                  DateTime(2023))
              .having((space) => space.logo, 'space logo url', "space-logo-url")
              .having(
                  (space) => space.ownerIds, 'space owners id list', ['uid'])
              .having((space) => space.paidTimeOff, 'yearly paid time-off', 12)
              .having((space) => space.domain, 'space website domain url link',
                  'website-url'));
    });

    test('apply correct employee to fire-store', () {
      Space space = Space(
          id: "unique-space-id",
          name: "dummy space",
          createdAt: DateTime(2023),
          paidTimeOff: 12,
          ownerIds: ['uid'],
          logo: "space-logo-url",
          domain: 'website-url');
      Map<String, dynamic> map = <String, dynamic>{
        'id': "unique-space-id",
        'name': "dummy space",
        'created_at': DateTime(2023).millisecondsSinceEpoch,
        'logo': "space-logo-url",
        'owner_ids': ['uid'],
        'paid_time_off': 12,
        'domain': 'website-url',
      };

      expect(space.toFirestore(), map);
    });
  });
}
