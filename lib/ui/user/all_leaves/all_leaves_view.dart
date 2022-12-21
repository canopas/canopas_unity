import 'package:flutter/material.dart';
import '/widget/leave_card.dart';
import 'bloc/leaves_bloc/all_leaves_event.dart';
import 'widget/filter_bottom_sheet.dart';
import '../../../../configs/colors.dart';
import '../../../di/service_locator.dart';
import '../../../widget/empty_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/leaves_bloc/all_leaves_bloc.dart';
import 'bloc/leaves_bloc/all_leaves_state.dart';
import '../../../../../../core/utils/const/space_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'bloc/filter_bloc/all_leaves_filter_bloc.dart';
import '../../../widget/circular_progress_indicator.dart';
import '../../../../../../widget/error_snack_bar.dart';

class AllLeavesPage extends StatelessWidget {

  const AllLeavesPage({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AllLeavesViewBloc>()..add(AllLeavesInitialLoadEvent()),
        ),
        BlocProvider(
          create: (_) => getIt<AllLeavesFilterBloc>(),
        ),
      ],
      child: const AllLeavesView(),
    );
  }
}

class AllLeavesView extends StatefulWidget {

  const AllLeavesView({Key? key}) : super(key: key);

  @override
  State<AllLeavesView> createState() => _AllLeavesViewState();
}

class _AllLeavesViewState extends State<AllLeavesView> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(localization.user_home_all_leaves_tag),
      ),
      body: BlocConsumer<AllLeavesViewBloc, AllLeavesViewState>(
        listenWhen: (previous, current) => current is AllLeavesViewFailureState,
        listener: (context, state) {
          if(state is AllLeavesViewFailureState){
              showSnackBar(context: context, error: state.error);
          }
        },
        builder: (context, state) {
          if (state is AllLeavesViewLoadingState) {
            return const AppCircularProgressIndicator();
          } else if (state is AllLeavesViewSuccessState) {
            if (state.leaveApplications.isEmpty) {
              return EmptyScreen(
                message: context.watch<AllLeavesFilterBloc>().state.filterApplied
                    ? localization.empty_filter_screen_message
                    : localization.employee_empty_all_leaves_view_message,
                title: context.watch<AllLeavesFilterBloc>().state.filterApplied
                    ? localization.empty_filter_screen_title
                    : localization.employee_empty_all_leaves_view_title,
                actionButtonTitle: localization.apply_for_leave_button_text,
                onActionButtonTap: () => context.read<AllLeavesViewBloc>().add(AllLeavesToLeaveRequestNavigationEvent()),
                showActionButton: !context.watch<AllLeavesFilterBloc>().state.filterApplied,
              );
            } else {
              return ListView.separated(
                itemCount: state.leaveApplications.length,
                padding: const EdgeInsets.all(primaryHorizontalSpacing).copyWith(bottom: 80),
                itemBuilder: (BuildContext context, int index) => LeaveCard(
                      onTap: () => context.read<AllLeavesViewBloc>().add(AllLeavesToLeaveDetailsNavigationEvent(state.leaveApplications[index])),
                      leaveApplication: state.leaveApplications[index]),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: primaryHorizontalSpacing),
              );
            }
          }
          return const SizedBox();
        },
      ),
      floatingActionButton:
          BlocBuilder<AllLeavesViewBloc, AllLeavesViewState>(
        builder: (context, state) {
          return state is AllLeavesViewSuccessState && (state.leaveApplications.isNotEmpty ||
                          context.watch<AllLeavesFilterBloc>().state.filterApplied)
                  ? FloatingActionButton.extended(
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          context: context,
                          builder: (_) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: context.read<AllLeavesFilterBloc>(),
                              ),
                              BlocProvider.value(
                                value: context.read<AllLeavesViewBloc>(),
                              ),
                            ],
                            child: const FilterBottomSheet(),
                          ),
                        );
                      },
                      label: Text(localization.user_filters_tag),
                      icon: const Icon(Icons.filter_list_rounded))
                  : const SizedBox();
        }
      ),
    );
  }

}
