import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/ui/shared/change_workspace_sheet/bloc/change_space_events.dart';
import 'package:projectunity/ui/shared/change_workspace_sheet/bloc/change_space_state.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import '../../../data/configs/colors.dart';
import '../../../data/configs/text_style.dart';
import '../../../data/configs/theme.dart';
import '../../../data/di/service_locator.dart';
import '../../widget/space_card.dart';
import 'bloc/change_space_bloc.dart';

class ChangeWorkspaceBottomSheet extends StatefulWidget {
  const ChangeWorkspaceBottomSheet({Key? key}) : super(key: key);

  @override
  State<ChangeWorkspaceBottomSheet> createState() => _ChangeWorkspaceBottomSheetState();
}

class _ChangeWorkspaceBottomSheetState extends State<ChangeWorkspaceBottomSheet> {
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
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                "Workspaces",
                style: AppFontStyle.titleDark,
              ),
            ),
            Expanded(
              child: BlocBuilder<ChangeSpaceBloc, ChangeSpaceStates>(
                  builder: (context, state) {
                if (state is ChangeSpaceLoadingState) {
                  return const AppCircularProgressIndicator();
                } else if (state is ChangeSpaceSuccessState) {
                  return ListView.builder(
                    itemCount: state.spaces.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) => SpaceCard(
                      title: state.spaces[index].name,
                      domain: state.spaces[index].domain,
                      onPressed: () => context.read<ChangeSpaceBloc>().add(SelectSpaceEvent(state.spaces[index])),
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
