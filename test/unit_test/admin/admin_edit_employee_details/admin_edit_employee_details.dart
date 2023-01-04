import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projectunity/core/extensions/date_time.dart';
import 'package:projectunity/exception/error_const.dart';
import 'package:projectunity/services/admin/employee/employee_service.dart';
import 'package:projectunity/ui/admin/edit_employe_details/bloc/admin_edit_employee_details_bloc.dart';
import 'package:projectunity/ui/admin/edit_employe_details/bloc/admin_edit_employee_details_events.dart';
import 'package:projectunity/ui/admin/edit_employe_details/bloc/admin_edit_employee_details_state.dart';

import 'admin_edit_employee_details.mocks.dart';

@GenerateMocks([EmployeeService])
void main(){
 late EmployeeService employeeService;
 late AdminEditEmployeeDetailsBloc editEmployeeDetailsBloc;
 DateTime joiningDate = DateTime.now().dateOnly;

 group("admin-edit-employee-details-test", () {

   setUp((){
     employeeService = MockEmployeeService();
     editEmployeeDetailsBloc = AdminEditEmployeeDetailsBloc(employeeService);
   });

   test('test initial test', (){
     editEmployeeDetailsBloc.add(AdminEditEmployeeDetailsInitialEvent(joiningDate: joiningDate.timeStampToInt,roleType:1 ));
     expect(editEmployeeDetailsBloc.stream, emits(AdminEditEmployeeDetailsState(dateOfJoining: joiningDate,roleType: 1)));
   });

   test('change role type test', (){
     editEmployeeDetailsBloc.emit(AdminEditEmployeeDetailsState(dateOfJoining: joiningDate,roleType: 1));
     editEmployeeDetailsBloc.add(ChangeRoleTypeAdminEditEmployeeDetailsEvents(roleType: 2));
     expect(editEmployeeDetailsBloc.stream, emits(AdminEditEmployeeDetailsState(dateOfJoining: joiningDate,roleType: 2)));
   });

   test('change joining date test', (){
     editEmployeeDetailsBloc.emit(AdminEditEmployeeDetailsState(dateOfJoining: joiningDate,roleType: 1));
     DateTime otherDate  = DateTime.now().add(const Duration(days: 5)).dateOnly;
     editEmployeeDetailsBloc.add(ChangeDateOfJoiningAdminEditEmployeeDetailsEvents(dateOfJoining: otherDate));
     expect(editEmployeeDetailsBloc.stream, emits(AdminEditEmployeeDetailsState(dateOfJoining: otherDate,roleType: 1)));
   });

   test('test validation validation', () {
     editEmployeeDetailsBloc.add(ValidNameAdminEditEmployeeDetailsEvents(name: ""));
     editEmployeeDetailsBloc.add(ValidNameAdminEditEmployeeDetailsEvents(name: "Tester Dummy"));
     expect(editEmployeeDetailsBloc.stream, emitsInOrder([
       const AdminEditEmployeeDetailsState(nameError: true),
       const AdminEditEmployeeDetailsState(nameError: false)
     ]));
   });

   test('test email validation', () {
     editEmployeeDetailsBloc.add(ValidEmailAdminEditEmployeeDetailsEvents(email: ""));
     editEmployeeDetailsBloc.add(ValidEmailAdminEditEmployeeDetailsEvents(email: "dummy123@gmail.com"));
     expect(editEmployeeDetailsBloc.stream, emitsInOrder([
       const AdminEditEmployeeDetailsState(emailError: true),
       const AdminEditEmployeeDetailsState(emailError: false)
     ]));
   });

   test('test designation validation', () {
     editEmployeeDetailsBloc.add(ValidDesignationAdminEditEmployeeDetailsEvents(designation: ""));
     editEmployeeDetailsBloc.add(ValidDesignationAdminEditEmployeeDetailsEvents(designation: "Application Tester"));
     expect(editEmployeeDetailsBloc.stream, emitsInOrder([
       const AdminEditEmployeeDetailsState(designationError: true),
       const AdminEditEmployeeDetailsState(designationError: false)
     ]));
   });

   test('test employeeId validation', () {
     editEmployeeDetailsBloc.add(ValidEmployeeIdAdminEditEmployeeDetailsEvents(employeeId: ""));
     editEmployeeDetailsBloc.add(ValidEmployeeIdAdminEditEmployeeDetailsEvents(employeeId: "CA-1000"));
     expect(editEmployeeDetailsBloc.stream, emitsInOrder([
       const AdminEditEmployeeDetailsState(employeeIdError: true),
       const AdminEditEmployeeDetailsState(employeeIdError: false)
     ]));
   });

   test('update Employee details test', () async {
     editEmployeeDetailsBloc.emit(AdminEditEmployeeDetailsState(dateOfJoining: joiningDate,roleType: 1));
     editEmployeeDetailsBloc.add(UpdateEmployeeDetailsAdminEditEmployeeDetailsEvents(id: "12", name: "Dummy tester", employeeId: "CA-1002", email:"dummy123@gmail.com", level: "SW-L2", designation: "Application tester",));
     expect(editEmployeeDetailsBloc.stream, emitsInOrder([
       AdminEditEmployeeDetailsState(dateOfJoining: joiningDate,roleType: 1,adminEditEmployeeDetailsStatus: AdminEditEmployeeDetailsStatus.loading),
       AdminEditEmployeeDetailsState(dateOfJoining: joiningDate,roleType: 1,adminEditEmployeeDetailsStatus: AdminEditEmployeeDetailsStatus.success),
     ]));
     await untilCalled(employeeService.adminUpdateEmployeeDetails(id: "12", name: "Dummy tester", employeeId: "CA-1002", email:"dummy123@gmail.com", level: "SW-L2", designation: "Application tester", roleType: 1, dateOfJoining: joiningDate.timeStampToInt));
     verify(employeeService.adminUpdateEmployeeDetails(id: "12", name: "Dummy tester", employeeId: "CA-1002", email:"dummy123@gmail.com", level: "SW-L2", designation: "Application tester", roleType: 1, dateOfJoining: joiningDate.timeStampToInt)).called(1);
   });

   test('update Employee details failed test', () async {
     editEmployeeDetailsBloc.emit(AdminEditEmployeeDetailsState(dateOfJoining: joiningDate,roleType: 1));
     when(employeeService.adminUpdateEmployeeDetails(id: "12", name: "Dummy tester", employeeId: "CA-1002", email:"dummy123@gmail.com", level: "SW-L2", designation: "Application tester", roleType: 1, dateOfJoining: joiningDate.timeStampToInt)).thenThrow(Exception("error"));
     editEmployeeDetailsBloc.add(UpdateEmployeeDetailsAdminEditEmployeeDetailsEvents(id: "12", name: "Dummy tester", employeeId: "CA-1002", email:"dummy123@gmail.com", level: "SW-L2", designation: "Application tester",));
     expect(editEmployeeDetailsBloc.stream, emitsInOrder([
       AdminEditEmployeeDetailsState(dateOfJoining: joiningDate,roleType: 1,adminEditEmployeeDetailsStatus: AdminEditEmployeeDetailsStatus.loading),
       AdminEditEmployeeDetailsState(dateOfJoining: joiningDate,roleType: 1,adminEditEmployeeDetailsStatus: AdminEditEmployeeDetailsStatus.failure,error: firestoreFetchDataError),
     ]));
     await untilCalled(employeeService.adminUpdateEmployeeDetails(id: "12", name: "Dummy tester", employeeId: "CA-1002", email:"dummy123@gmail.com", level: "SW-L2", designation: "Application tester", roleType: 1, dateOfJoining: joiningDate.timeStampToInt));
     verify(employeeService.adminUpdateEmployeeDetails(id: "12", name: "Dummy tester", employeeId: "CA-1002", email:"dummy123@gmail.com", level: "SW-L2", designation: "Application tester", roleType: 1, dateOfJoining: joiningDate.timeStampToInt)).called(1);
   });

 });
}