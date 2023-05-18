import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/extensions/date_time.dart';
import 'package:projectunity/data/model/employee/employee.dart';
import 'package:projectunity/data/provider/user_data.dart';
import 'package:projectunity/ui/shared/profile/view_profile/bloc/view_profile_bloc.dart';
import 'package:projectunity/ui/shared/profile/view_profile/bloc/view_profile_event.dart';
import 'package:projectunity/ui/shared/profile/view_profile/bloc/view_profile_state.dart';
import 'package:projectunity/ui/shared/profile/view_profile/widget/basic_detail_section.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../../../data/di/service_locator.dart';
import '../../../navigation/app_router.dart';
import '../../../widget/employee_details_field.dart';

class ViewProfilePage extends StatelessWidget {
  const ViewProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ViewProfileBloc>(
      create: (_) => getIt<ViewProfileBloc>()..add(InitialLoadevent()),
      child: const ViewProfileScreen(),
    );
  }
}

class ViewProfileScreen extends StatelessWidget {
  const ViewProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(localization.admin_employee_detail_profile_tag),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: TextButton(
                onPressed: () => context.pushNamed(getIt<UserManager>().isAdmin
                    ? Routes.adminEditProfile
                    : Routes.userEditProfile),
                child: Text(localization.edit_tag),
              ),
            ),
          ]),
      body: BlocConsumer<ViewProfileBloc, ViewProfileState>(
          listenWhen: (previous, current) => current is ViewProfileErrorState,
          listener: (context, state) {
            if (state is ViewProfileErrorState) {
              showSnackBar(context: context, error: state.error);
            }
          },
          buildWhen: (previous, current) =>
              current is ViewProfileSuccessState ||
              current is ViewProfileLoadingState,
          builder: (context, state) {
            if (state is ViewProfileLoadingState) {
              return const AppCircularProgressIndicator();
            } else if (state is ViewProfileSuccessState) {
              final Employee employee = state.employee;
              return ListView(
                children: [
                  BasicDetailSection(employee: employee),
                  EmployeeDetailsField(
                      title: AppLocalizations.of(context).employee_level_tag,
                      subtitle: employee.level),
                  EmployeeDetailsField(
                      title:
                          AppLocalizations.of(context).employee_dateOfJoin_tag,
                      subtitle: localization
                          .date_format_yMMMd(employee.dateOfJoining.toDate)),
                  EmployeeDetailsField(
                      title:
                          AppLocalizations.of(context).employee_dateOfBirth_tag,
                      subtitle: employee.dateOfBirth == null
                          ? null
                          : localization
                              .date_format_yMMMd(employee.dateOfBirth!.toDate)),
                  EmployeeDetailsField(
                      title: AppLocalizations.of(context).employee_gender_tag,
                      subtitle: employee.gender == null
                          ? null
                          : localization.user_details_gender(employee.gender!)),
                  EmployeeDetailsField(
                      title: AppLocalizations.of(context).employee_address_tag,
                      subtitle: employee.address),
                ],
              );
            }
            return const SizedBox();
          }),
    );
  }
}
