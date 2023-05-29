import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/core/extensions/string_extension.dart';
import 'package:projectunity/data/provider/user_state.dart';
import 'package:projectunity/ui/shared/appbar_drawer/appbar/space_notifier_widget.dart';

import '../../../../data/configs/colors.dart';
import '../../../../data/configs/space_constant.dart';
import '../../../../data/configs/text_style.dart';
import '../../../../data/di/service_locator.dart';
import '../../../widget/space_logo_view.dart';
import '../../../widget/widget_validation.dart';
import '../drawer/bloc/app_drawer_bloc.dart';
import '../drawer/bloc/app_drawer_event.dart';

class DashBoardAppBar extends StatelessWidget implements PreferredSize {
  final Function onTap;
  @override
  final Size preferredSize;

  const DashBoardAppBar({Key? key, required this.onTap})
      : preferredSize = const Size.fromHeight(80),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: primaryHorizontalSpacing),
      alignment: Alignment.bottomCenter,
      decoration: const BoxDecoration(color: AppColors.whiteColor),
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
                  child: SpaceNotifierWidget(
                    notifier: getIt.get<UserStateNotifier>(),
                    child: Builder(builder: (context) {
                      return SpaceLogoView(
                          spaceLogoUrl: SpaceNotifierWidget.of(context)?.logo);
                    }),
                  )),
              const SizedBox(width: primaryHorizontalSpacing),
              Expanded(
                child: SpaceNotifierWidget(
                  notifier: getIt.get<UserStateNotifier>(),
                  child: Builder(
                    builder: (context) {
                      final String name =
                          SpaceNotifierWidget.of(context)?.name ?? "";
                      final String? domain =
                          SpaceNotifierWidget.of(context)?.domain;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name,
                              style: AppFontStyle.titleDark,
                              overflow: TextOverflow.ellipsis),
                          ValidateWidget(
                            isValid: domain.isNotNullOrEmpty,
                            child: Text(
                              domain ?? "",
                              style: AppFontStyle.subTitleGrey,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      );
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
