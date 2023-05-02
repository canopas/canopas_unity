import 'package:projectunity/data/model/employee/employee.dart';

import '../../model/user/user.dart';

extension ToEmployee on User {
  Employee get employee =>
      Employee(uid: uid, name: name ?? email.split('.')[0], email: email);
}
