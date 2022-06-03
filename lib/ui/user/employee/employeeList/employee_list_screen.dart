import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:projectunity/ui/user/employee/employeeList/widget/serach_bar.dart';
import 'package:projectunity/utils/const/color_constant.dart';

import '../../../../di/service_locator.dart';
import '../../../../model/employee/employee.dart';
import '../../../../rest/api_response.dart';
import '../../../../viewmodel/employee_list_bloc.dart';
import '../../../../widget/error_banner.dart';
import 'widget/employee_list.dart';
import 'widget/header_content.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final _bloc = getIt<EmployeeListBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.getEmployeeList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: const Color(appBarColor),
        body: NestedScrollView(
          controller: ScrollController(),
          headerSliverBuilder: (_, __) => [
            SliverAppBar(
              floating: true,
              expandedHeight: 100,
              backgroundColor: const Color(appBarColor),
              flexibleSpace: FlexibleSpaceBar(
                background: HeaderContent(),
              ),
            )
          ],
          body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
                const SearchBar(),
                StreamBuilder<ApiResponse<List<Employee>>>(
                    initialData: const ApiResponse.idle(),
                    stream: _bloc.allEmployee,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      return snapshot.data!.when(idle: () {
                        return Container();
                      }, loading: () {
                        return const SizedBox(
                            child: Center(
                                child: CircularProgressIndicator(
                          color: Color(kPrimaryColour),
                        )));
                      }, completed: (List<Employee> list) {
                        return EmployeeList(employees: list);
                      }, error: (String error) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          showErrorBanner(error, context);
                        });

                        return const Center(child: CircularProgressIndicator());
                      });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
