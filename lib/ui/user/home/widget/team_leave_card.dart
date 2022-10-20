import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import '../../../../configs/colors.dart';
import '../../../../configs/text_style.dart';
import '../../../../model/leave_application.dart';

class TeamLeaveCard extends StatelessWidget {
  final void Function()? onTap;
  final List<LeaveApplication> leaveApplication;

  const TeamLeaveCard(
      {Key? key, required this.onTap, required this.leaveApplication})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7,horizontal: 4),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: AppColors.primaryBlue, width: 5))
      ),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: primaryHorizontalSpacing, bottom: primaryHorizontalSpacing, left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context).who_is_out_card_title,
                      style: AppTextStyle.titleBlack600,
                    ),
                    const SizedBox(height: primaryVerticalSpacing,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.72,
                      child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            ...leaveApplication.map((e) => Container(
                              margin: const EdgeInsets.only(right: primaryVerticalSpacing,bottom: primaryVerticalSpacing),
                              height: MediaQuery.of(context).size.width * 0.12,
                              width: MediaQuery.of(context).size.width * 0.12,
                              decoration: BoxDecoration(
                                image: (e.employee.imageUrl != null)?DecorationImage(
                                  image: NetworkImage(e.employee.imageUrl!),
                                ):null,
                                color: AppColors.primaryGray,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: (e.employee.imageUrl != null)?null:const Icon(Icons.person,size: 30,color: Colors.black54),
                            )).take(5),
                        Text(AppLocalizations.of(context).who_is_out_card_message(leaveApplication.length<2?leaveApplication.length:leaveApplication.length-1, (leaveApplication.isEmpty)?"":leaveApplication!.first.employee.name), style: AppTextStyle.secondarySubtitle500,),
                      ]),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 1),
              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(
                  Icons.chevron_right,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
