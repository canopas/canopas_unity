import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/configs/theme.dart';
import 'package:projectunity/core/utils/const/image_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'widget/who_is_out_card.dart';
import '../../../configs/colors.dart';
import '../../../core/utils/const/space_constant.dart';
import '../../../di/service_locator.dart';
import 'bloc/user_home_event.dart';
import 'bloc/user_home_bloc.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt<UserHomeBloc>()..add(UserHomeFetchEvent()),
      child: const UserHomeScreen(),
    );
  }
}

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(primaryHorizontalSpacing),
          children:  [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.whiteColor,
                    boxShadow: AppTheme.commonBoxShadow,
                    image:  const DecorationImage(
                      image: NetworkImage(ImageConst.companyLogo)
                    ),
                  ),
                ),
                const SizedBox(width: primaryHorizontalSpacing,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(AppLocalizations.of(context).company_name,style: AppTextStyle.titleDark,overflow: TextOverflow.ellipsis),
                    Text(AppLocalizations.of(context).company_subtitle,style: AppTextStyle.bodyDark,)
                  ],
                ),
                const Spacer(),
                const CircleAvatar(
                  radius: 22,
                  backgroundColor: Color(0xffF5F5F5),
                  child: Icon(Icons.notifications_none_rounded,color: AppColors.textDark,),
                ),
              ],
            ),
            const SizedBox(height: primaryHorizontalSpacing,),
            const WhoIsOutCard(),
          ],
        ),
      ),
      backgroundColor: AppColors.whiteColor,
    );
  }
}


