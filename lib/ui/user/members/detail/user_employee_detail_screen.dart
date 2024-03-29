import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/configs/space_constant.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/style/app_page.dart';
import 'package:projectunity/ui/user/members/detail/bloc/user_employee_detail_state.dart';
import 'package:projectunity/ui/user/members/detail/widget/employee_info.dart';
import 'package:projectunity/ui/user/members/detail/widget/tab_content.dart';
import '../../../../data/model/employee/employee.dart';
import '../../../admin/members/detail/widget/profile_card.dart';
import 'bloc/user_employee_detail_bloc.dart';
import 'bloc/user_employee_detail_event.dart';

class UserEmployeeDetailPage extends StatelessWidget {
  final Employee employee;

  const UserEmployeeDetailPage({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserEmployeeDetailBloc>(
        create: (_) => getIt<UserEmployeeDetailBloc>(),
        child: UserEmployeeDetailScreen(employee: employee));
  }
}

class UserEmployeeDetailScreen extends StatefulWidget {
  final Employee employee;

  const UserEmployeeDetailScreen({super.key, required this.employee});

  @override
  State<UserEmployeeDetailScreen> createState() =>
      _UserEmployeeDetailScreenState();
}

class _UserEmployeeDetailScreenState extends State<UserEmployeeDetailScreen> {
  @override
  void initState() {
    if (widget.employee.role != Role.admin) {
      context
          .read<UserEmployeeDetailBloc>()
          .add(UserEmployeeDetailFetchEvent(uid: widget.employee.uid));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
        backGroundColor: context.colorScheme.surface,
        title: context.l10n.details_tag,
        body: ListView(
          padding:
              const EdgeInsets.symmetric(vertical: primaryHorizontalSpacing),
          children: [
            ProfileCard(employee: widget.employee),
            const Divider(
              indent: primaryHorizontalSpacing,
              endIndent: primaryHorizontalSpacing,
            ),
            EmployeeInfo(employee: widget.employee),
            const SizedBox(height: 16),
            BlocBuilder<UserEmployeeDetailBloc, UserEmployeeDetailState>(
              builder: (context, state) =>
                  state is UserEmployeeDetailSuccessState &&
                          state.upcomingLeaves.isNotEmpty
                      ? const Divider(
                          indent: primaryHorizontalSpacing,
                          endIndent: primaryHorizontalSpacing,
                        )
                      : const SizedBox(),
            ),
            const TabContent(),
          ],
        ));
  }
}
