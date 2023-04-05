import 'package:flutter/material.dart';
import '../../data/configs/colors.dart';
import '../../data/configs/text_style.dart';
import '../../data/configs/theme.dart';
import '../../data/core/utils/const/image_constant.dart';
import '../space/join_space/widget/workspace_card.dart';

class ChangeWorkspaceBottomSheet extends StatelessWidget {
  const ChangeWorkspaceBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: List.generate(
                  3,
                  (index) => WorkSpaceCard(
                        title: "Canopas Software",
                        members: 24,
                        imageURL: ImageConst.companyLogo,
                        onPressed: () {
                          ///TODO: implement workspace card tap event
                        },
                      )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
