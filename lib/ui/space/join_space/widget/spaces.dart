import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../widget/circular_progress_indicator.dart';
import '../../../widget/space_card.dart';
import '../bloc/join_space_bloc.dart';
import '../bloc/join_space_event.dart';
import '../bloc/join_space_state.dart';

class Spaces extends StatelessWidget {
  const Spaces({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JoinSpaceBloc, JoinSpaceState>(
        buildWhen: (previous, current) =>
            current.fetchSpaceStatus == Status.success ||
            current.fetchSpaceStatus == Status.error,
        builder: (context, state) {
          if (state.fetchSpaceStatus == Status.loading ||
              state.fetchSpaceStatus == Status.initial) {
            return const Padding(
              padding: EdgeInsets.all(20),
              child: AppCircularProgressIndicator(),
            );
          } else {
            if (state.ownSpaces.isEmpty && state.requestedSpaces.isEmpty) {
              return Text(
                context.l10n.empty_space_list_msg,
                style: AppTextStyle.style14
                    .copyWith(color: context.colorScheme.textSecondary),
              );
            }
            return Expanded(
              child: ListView(
                children: [
                  if (state.ownSpaces.isNotEmpty)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: state.ownSpaces
                          .map((space) => SpaceCard(
                                name: space.name,
                                domain: space.domain,
                                logo: space.logo,
                                onPressed: () => context
                                    .read<JoinSpaceBloc>()
                                    .add(SelectSpaceEvent(space: space)),
                              ))
                          .toList(),
                    ),
                  if (state.requestedSpaces.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(context.l10n.request_tag,
                              style: AppTextStyle.style18.copyWith(
                                  color: context.colorScheme.textPrimary)),
                        ),
                        Column(
                          children: state.requestedSpaces
                              .map((space) => SpaceCard(
                                    name: space.name,
                                    domain: space.domain,
                                    logo: space.logo,
                                    onPressed: () => context
                                        .read<JoinSpaceBloc>()
                                        .add(JoinRequestedSpaceEvent(
                                            space: space)),
                                  ))
                              .toList(),
                        )
                      ],
                    ),
                ],
              ),
            );
          }
        });
  }
}
