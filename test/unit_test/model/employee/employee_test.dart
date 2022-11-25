import 'package:flutter_test/flutter_test.dart';
import 'package:projectunity/model/employee/employee.dart';

void main() {
  group("Employee", () {
    group('from json and from firestore', () {
      test('returns correct Employee object ', () {
        expect(Employee.fromJson(<String,dynamic>{
          'id': 'unique-user-doc-id',
          'role_type':1,
          'name': 'Andrew jhone',
          'employee_id': 'CA 1254',
          'email': 'andrewjhone@gmail.com',
          'designation': 'Android developer',
          'phone': '',
          'image_url': '',
          'address': '',
          'gender': 2,
          'date_of_birth': 6465456,
          'date_of_joining': 875425,
          'level': 'L1',
          'blood_group': 'AB+'
        }), isA<Employee>()
            .having((employee) => employee.id, 'unique employee id', 'unique-user-doc-id')
            .having((employee) => employee.roleType, 'Employee role:1-Admin, 2-Employee', 1)
            .having((employee) => employee.name, 'Name of employee', 'Andrew jhone')
            .having((employee) => employee.employeeId, 'Employee id', 'CA 1254')
            .having((employee) => employee.email, 'Email of employee', 'andrewjhone@gmail.com').
            having((employee) => employee.designation, 'Designation of employee', 'Android developer')
            .having((employee) => employee.phone, 'Phone number of employee', '')
            .having((employee) => employee.imageUrl, 'Image Url of employee', '')
            .having((employee) => employee.address, 'Address of employee', '')
            .having((employee) => employee.gender, 'Gender', 2)
            .having((employee) => employee.dateOfBirth, 'Date Of Birth-Timestamp to int', 6465456)
            .having((employee) => employee.dateOfJoining, 'Date Of Joining-Timestamp to int', 875425)
            .having((employee) => employee.level, 'Level of employee', 'L1')
            .having((employee) => employee.bloodGroup, 'Blood group', 'AB+')
        );
      });
    });

    test('apply correct employee to firestore', () {
      Employee employee= Employee(
          id: 'Unique-user-id',
          roleType: 1,
          name: 'Andrew jhone',
          employeeId: 'CA 1255',
          email: 'andrew.j@canopas.com',
          designation: 'Android developer',
        phone: '',
        imageUrl: '',
          address: '',
        level: '',
        bloodGroup: '',



      );
      Map<String,dynamic> map= <String,dynamic>{
        'id': employee.id,
        'role_type':employee.roleType,
        'name': employee.name,
        'employee_id': employee.employeeId,
        'email': employee.email,
        'designation': employee.designation,
        'phone': employee.phone,
        'image_url': employee.imageUrl,
        'address': employee.address,
        'gender':employee.gender,
        'date_of_birth': employee.dateOfBirth,
        'date_of_joining': employee.dateOfJoining,
        'level': employee.level,
        'blood_group': employee.bloodGroup
      };

      expect(employee.toJson(), map);
    });
  });
}