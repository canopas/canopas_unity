import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/ui/shared/appbar_drawer/appbar/space_notifier_widget.dart';
import '../../../../data/configs/space_constant.dart';
import '../../../../data/di/service_locator.dart';
import '../../../../style/app_text_style.dart';
import '../drawer/bloc/app_drawer_bloc.dart';
import '../drawer/bloc/app_drawer_event.dart';

class DashBoardAppBar extends StatelessWidget implements PreferredSize {
  final Function onTap;
  @override
  final Size preferredSize;

  const DashBoardAppBar({super.key, required this.onTap})
      : preferredSize = const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: primaryHorizontalSpacing),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(color: context.colorScheme.surface),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    onTap();
                    context.read<DrawerBloc>().add(FetchSpacesEvent());
                  },
                  child: Icon(
                    Icons.menu,
                    color: context.colorScheme.textPrimary,
                  )),
              const SizedBox(width: primaryHorizontalSpacing),
              Expanded(
                child: SpaceNotifierWidget(
                  notifier: getIt.get<UserStateNotifier>(),
                  child: Builder(
                    builder: (context) {
                      final String name =
                          SpaceNotifierWidget.of(context)?.name ?? "";
                      return Text(name,
                          style: AppTextStyle.style20
                              .copyWith(color: context.colorScheme.textPrimary),
                          overflow: TextOverflow.ellipsis);
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: primaryHalfSpacing),
          const Divider(height: 1)
        ],
      ),
    );
  }

  @override
  Widget get child => const SizedBox();
}
