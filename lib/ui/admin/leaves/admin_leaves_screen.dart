import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/theme.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/ui/admin/leaves/bloc%20/admin_leave_event.dart';
import 'package:projectunity/ui/admin/leaves/bloc%20/admin_leaves_bloc.dart';
import 'package:projectunity/ui/admin/leaves/bloc%20/admin_leaves_state.dart';
import 'package:projectunity/widget/app_app_bar.dart';
import 'package:projectunity/widget/error_snack_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class AdminLeavesPage extends StatelessWidget {
  const AdminLeavesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<AdminLeavesBloc>()..add(AdminLeavesInitialLoadEvent()),
      child: const AdminLeavesScreen(),
    );
  }
}

class AdminLeavesScreen extends StatefulWidget {
  const AdminLeavesScreen({Key? key}) : super(key: key);

  @override
  State<AdminLeavesScreen> createState() => _AdminLeavesScreenState();
}

class _AdminLeavesScreenState extends State<AdminLeavesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (kDebugMode) {
        print("it's bottom");
      }
      context.read<AdminLeavesBloc>().add(AdminFetchMoreRecentLeavesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: AppLocalizations.of(context).admin_leave_appbar_text,
      ),
      body: BlocConsumer<AdminLeavesBloc, AdminLeavesState>(
        listener: (context, state) {
          if (state.status == AdminLeavesStatus.failure) {
            showSnackBar(context: context, error: state.error);
          }
        },
        builder: (context, state) => ListView(
          controller: _scrollController,
          children: [
            ...state.recentLeaves
                .map((e) => Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: primaryHorizontalSpacing,vertical: primaryHalfSpacing),
                    height: 300,
                    width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: AppTheme.commonBorderRadius,
                boxShadow: AppTheme.commonBoxShadow,
              ),
              child: Text(state.recentLeaves.indexOf(e).toString()),))
                .toList(),
            state.fetchMoreRecentLeaves?const Center(child: CircularProgressIndicator()):const SizedBox(),
          ],
        ),
      ),
      backgroundColor: AppColors.whiteColor,
    );
  }
}
