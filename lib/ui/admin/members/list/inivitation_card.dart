import 'package:flutter/material.dart';
import '../../../../data/configs/colors.dart';
import '../../../../data/configs/space_constant.dart';
import '../../../../data/configs/text_style.dart';
import '../../../../data/model/invitation/invitation.dart';

class InvitedMemberCard extends StatelessWidget {
  final Invitation invitation;

  const InvitedMemberCard({Key? key, required this.invitation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.dividerColor,
          child: Icon(Icons.person, size: 25, color: AppColors.greyColor),
        ),
        const SizedBox(width: primaryHorizontalSpacing),
        Flexible(
          child: Text(invitation.receiverEmail,
              style: AppFontStyle.bodyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1),
        )
      ],
    );
  }
}
