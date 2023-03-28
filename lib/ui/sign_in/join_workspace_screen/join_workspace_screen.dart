import 'package:flutter/material.dart';
import 'package:projectunity/data/configs/space_constant.dart';
import 'package:projectunity/data/configs/text_style.dart';
import 'package:projectunity/data/configs/theme.dart';
import 'package:projectunity/data/core/utils/const/image_constant.dart';
import 'package:projectunity/ui/sign_in/join_workspace_screen/widget/workspace_card.dart';


import '../../../data/configs/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class WorkSpaceScreen extends StatefulWidget {
  const WorkSpaceScreen({Key? key}) : super(key: key);

  @override
  State<WorkSpaceScreen> createState() => _WorkSpaceScreenState();
}

class _WorkSpaceScreenState extends State<WorkSpaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding:
              const EdgeInsets.all(primaryHorizontalSpacing).copyWith(top: 32),
          children: [
            Text(
              AppLocalizations.of(context).welcome_to_unity_text,
              style: AppFontStyle.titleDark,
            ),
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context).create_own_workspace_title,
                style: AppFontStyle.bodyLarge),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  surfaceTintColor: AppColors.lightPrimaryBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: AppTheme.commonBorderRadius),
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 45)),
              onPressed: () {
                ///TODO: Add Implementation for Create New Space
              },
              child: Text(AppLocalizations.of(context).create_new_workspace_title),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                const Divider(),
                Container(
                    color: AppColors.whiteColor,
                    padding: const EdgeInsets.all(primarySpacing),
                    child: Text(
                      AppLocalizations.of(context).or_tag,
                      style: AppFontStyle.bodyLarge
                          .copyWith(color: AppColors.secondaryText),
                    ))
              ],
            ),
            Text(
                AppLocalizations.of(context)
                    .workspaces_list_title("pratik.k@canopas.com"),
                style: AppFontStyle.bodyLarge),
            const SizedBox(height: 10),

            ///TODO: show List of WorkspaceCards
            ...List.generate(
                3,
                (index) => WorkSpaceCard(
                      imageURL: ImageConst.companyLogo,
                      onPressed: () {
                        ///TODO: implement workspace card tap event
                      },
                    )).toList(),
          ],
        ),
      ),
    );
  }
}
