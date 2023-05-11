import 'package:flutter_test/flutter_test.dart';
import 'package:projectunity/data/model/account/account.dart';

void main() {
  group("User", () {
    test('Test returns correct Employee object from json and from fire-store',
        () {
      expect(
          Account.fromJson(const <String, dynamic>{
            'uid': "unique-user-id",
            'email': "dummy@canopas.com",
            'name': "dummy",
            'spaces': ["space-id"],
          }),
          isA<Account>()
              .having(
                  (user) => user.uid, 'unique user auth id', "unique-user-id")
              .having(
                  (user) => user.email, 'user auth email', "dummy@canopas.com")
              .having((user) => user.name, 'unique user auth name', "dummy")
              .having(
                  (user) => user.spaces, 'user spaces id list', ["space-id"]));
    });

    test('apply correct employee to fire-store', () {
      const Account user = Account(
        uid: "unique-user-id",
        email: "dummy@canopas.com",
        name: "dummy",
        spaces: ["space-id"],
      );
      const Map<String, dynamic> map = <String, dynamic>{
        'uid': "unique-user-id",
        'email': "dummy@canopas.com",
        'name': "dummy",
        'spaces': ["space-id"],
      };

      expect(user.toJson(), map);
    });
  });
}
