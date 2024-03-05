import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/style/app_text_style.dart';
import 'package:projectunity/ui/admin/members/list/bloc/member_list_bloc.dart';
import 'package:projectunity/ui/admin/members/list/bloc/member_list_event.dart';
import '../../../../data/configs/space_constant.dart';
import '../../../../data/model/invitation/invitation.dart';

class InvitedMemberCard extends StatelessWidget {
  final Invitation invitation;

  const InvitedMemberCard({super.key, required this.invitation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: context.colorScheme.containerHigh,
            child: Icon(Icons.person,
                size: 25, color: context.colorScheme.containerHigh),
          ),
          const SizedBox(width: primaryHorizontalSpacing),
          Expanded(
            child: Text(invitation.receiverEmail,
                style: AppTextStyle.style16
                    .copyWith(color: context.colorScheme.textPrimary),
                overflow: TextOverflow.ellipsis,
                maxLines: 1),
          ),
          IconButton(
              onPressed: () {
                context
                    .read<AdminMembersBloc>()
                    .add(CancelUserInvitation(invitation.id));
              },
              icon: Icon(
                Icons.close,
                color: context.colorScheme.textPrimary,
                size: 15,
              ))
        ],
      ),
    );
  }
}
