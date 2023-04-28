import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';
import '../../../data/configs/colors.dart';
import '../../../data/configs/text_style.dart';
import '../../../data/configs/theme.dart';
import '../../../data/core/utils/bloc_status.dart';
import '../../../data/di/service_locator.dart';
import '../../widget/space_card.dart';
import 'bloc/change_space_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'bloc/change_space_events.dart';
import 'bloc/change_space_state.dart';

class ChangeSpaceBottomSheet extends StatefulWidget {
  const ChangeSpaceBottomSheet({Key? key}) : super(key: key);

  @override
  State<ChangeSpaceBottomSheet> createState() => _ChangeSpaceBottomSheetState();
}

class _ChangeSpaceBottomSheetState extends State<ChangeSpaceBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChangeSpaceBloc>()..add(ChangeSpaceInitialLoadEvent()),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          color: AppColors.whiteColor,
          boxShadow: AppTheme.commonBoxShadow,
        ),
        child: Column(
          children: [
             Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                AppLocalizations.of(context).spaces_title,
                style: AppFontStyle.titleDark,
              ),
            ),
            Expanded(
              child: BlocConsumer<ChangeSpaceBloc, ChangeSpaceState>(
                listener: (context, state){
                  if(state.error != null){
                    context.pop();
                    showSnackBar(context: context,error: state.error);
                  }
                },
                buildWhen: (previous, current) => previous.fetchSpaceStatus != current.fetchSpaceStatus,
                  builder: (context, state) {
                    if (state.fetchSpaceStatus == Status.loading) {
                      return const AppCircularProgressIndicator();
                    } else if (state.fetchSpaceStatus == Status.success) {
                      return ListView.builder(
                        itemCount: state.spaces.length,
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (context, index) => SpaceCard(
                          title: state.spaces[index].name,
                          domain: state.spaces[index].domain,
                          onPressed: () => context
                              .read<ChangeSpaceBloc>()
                              .add(SelectSpaceEvent(state.spaces[index])),
                        ),
                      );
                    }
                    return const SizedBox();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
