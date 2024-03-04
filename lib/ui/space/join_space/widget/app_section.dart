import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../style/app_text_style.dart';
import '../../../../style/other/app_button.dart';
import '../../../navigation/app_router.dart';

class AppSection  extends StatelessWidget {
  const AppSection({super.key});

  @override
  Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.images.appLogo),
          const SizedBox(
            height: 20,
          ),
          Text(
            context.l10n.welcome_to_unity_text,
            style: AppTextStyle.style24,
          ),
          const SizedBox(height: 20),
          Text(context.l10n.create_own_space_title,
              style: AppTextStyle.style18.copyWith(height: 2.0)),
          const SizedBox(height: 20),
          AppButton(
              tag: context.l10n.create_new_space_title,
              onTap: () => context.goNamed(Routes.createSpace)),
        ],
      );
  }
}
