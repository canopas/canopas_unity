import 'package:flutter_test/flutter_test.dart';
import 'package:projectunity/data/model/employee/employee.dart';

void main() {
  group("Employee", () {
    group('from json and from firestore', () {
      test('returns correct Employee object ', () {
        expect(
            Employee.fromJson(<String, dynamic>{
              'uid': 'unique-user-doc-id',
              'role': 1,
              'name': 'Andrew jhone',
              'employee_id': 'CA 1254',
              'email': 'andrewjhone@gmail.com',
              'designation': 'Android developer',
              'phone': '',
              'image_url': '',
              'address': '',
              'gender': 2,
              'date_of_birth': DateTime(2000).millisecondsSinceEpoch,
              'date_of_joining': DateTime(2000).millisecondsSinceEpoch,
              'level': 'L1',
              'status': 1
            }),
            isA<Employee>()
                .having((employee) => employee.uid, 'unique employee id',
                    'unique-user-doc-id')
                .having((employee) => employee.role,
                    'Employee role:1-Admin, 2-Employee', Role.admin)
                .having((employee) => employee.name, 'Name of employee',
                    'Andrew jhone')
                .having(
                    (employee) => employee.employeeId, 'Employee id', 'CA 1254')
                .having((employee) => employee.email, 'Email of employee',
                    'andrewjhone@gmail.com')
                .having((employee) => employee.designation,
                    'Designation of employee', 'Android developer')
                .having((employee) => employee.phone,
                    'Phone number of employee', '')
                .having((employee) => employee.imageUrl,
                    'Image Url of employee', '')
                .having(
                    (employee) => employee.address, 'Address of employee', '')
                .having((employee) => employee.gender, 'Gender', Gender.female)
                .having((employee) => employee.dateOfBirth,
                    'Date Of Birth-Timestamp to int', DateTime(2000))
                .having((employee) => employee.dateOfJoining,
                    'Date Of Joining-Timestamp to int', DateTime(2000))
                .having(
                    (employee) => employee.status,
                    'status int to enum(active, inactive)',
                    EmployeeStatus.active)
                .having(
                    (employee) => employee.level, 'Level of employee', 'L1'));
      });
    });

    test('apply correct employee to firestore', () {
      Employee employee = Employee(
          uid: 'Unique-user-id',
          role: Role.admin,
          name: 'Andrew jhone',
          employeeId: 'CA 1255',
          email: 'andrew.j@canopas.com',
          designation: 'Android developer',
          phone: '',
          imageUrl: '',
          address: '',
          level: '',
          gender: Gender.male,
          dateOfBirth: null,
          status: EmployeeStatus.active,
          dateOfJoining: DateTime(2000));
      Map<String, dynamic> map = <String, dynamic>{
        'uid': employee.uid,
        'role': Role.admin.value,
        'name': employee.name,
        'employee_id': employee.employeeId,
        'email': employee.email,
        'designation': employee.designation,
        'phone': employee.phone,
        'image_url': employee.imageUrl,
        'address': employee.address,
        'level': employee.level,
        'gender': employee.gender!.value,
        'date_of_joining': employee.dateOfJoining.millisecondsSinceEpoch,
        'status': employee.status.value,
      };

      expect(employee.toJson(), map);
    });
  });
}
