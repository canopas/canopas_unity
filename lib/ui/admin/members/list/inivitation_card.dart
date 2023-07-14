import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/ui/admin/members/list/bloc/member_list_bloc.dart';
import 'package:projectunity/ui/admin/members/list/bloc/member_list_event.dart';
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
        Expanded(
          child: Text(invitation.receiverEmail,
              style: AppFontStyle.bodyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1),
        ),
        IconButton(
            onPressed: () {
              context
                  .read<AdminMembersBloc>()
                  .add(CancelUserInvitation(invitation.id));
            },
            icon: const Icon(Icons.close))
      ],
    );
  }
}
