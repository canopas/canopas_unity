import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_bloc.dart';
import 'package:projectunity/ui/admin/employee/detail/bloc/employee_detail_event.dart';

import '../../../../../../configs/colors.dart';

class DeleteButton extends StatelessWidget {
  final String id;

  const DeleteButton({Key? key,required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(0.8),
          spreadRadius: 10,
          blurRadius: 5,
          offset: const Offset(0, 7),
        )
      ]),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 4),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.redColor,
            ),
            onPressed: (){
              context.read<EmployeeDetailBloc>().add(DeleteEmployeeEvent(employeeId: id));
              context.pop();
            },
            child: Text(
              AppLocalizations.of(context).user_leave_detail_button_delete,
              style: AppTextStyle.subtitleText,
            )),
      ),
    );
  }
}
