import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/ui/admin/employee/detail/widget/delete_button.dart';
import 'package:projectunity/widget/circular_progress_indicator.dart';
import 'package:projectunity/widget/error_snack_bar.dart';
import '../../../../../di/service_locator.dart';
import 'bloc/employee_detail_bloc.dart';
import 'bloc/employee_detail_event.dart';
import 'bloc/employee_detail_state.dart';
import 'widget/profile_card.dart';
import 'widget/profile_detail.dart';


class EmployeeDetailPage extends StatelessWidget {
 final String id;
  const EmployeeDetailPage({Key? key,required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmployeeDetailBloc>(
        create:(_)=> getIt<EmployeeDetailBloc>()..add(EmployeeDetailInitialLoadEvent(employeeId: id)),
      child: EmployeeDetailScreen(employeeId:id));
  }
}


class EmployeeDetailScreen extends StatefulWidget {
  final String employeeId;

  const EmployeeDetailScreen({Key? key,required this.employeeId}) : super(key: key);

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
 late String employeeId ;
  @override
  void initState() {
    employeeId= widget.employeeId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: BlocConsumer<EmployeeDetailBloc,AdminEmployeeDetailState>(
        builder: (BuildContext context,AdminEmployeeDetailState state) {
          if (state is EmployeeDetailLoadingState) {
              return const AppCircularProgressIndicator();
            } else if (state is EmployeeDetailLoadedState) {
              final employee = state.employee;
              return ListView(children: [
                ProfileCard(employee: employee),
                ProfileDetail(employee: employee),
              ]);
            }
            return const SizedBox();
          },
        listener: (BuildContext context,AdminEmployeeDetailState state){
          if(state is EmployeeDetailFailureState){
            showSnackBar(context: context,error: state.error);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: DeleteButton(id: employeeId)
    );
  }
}
