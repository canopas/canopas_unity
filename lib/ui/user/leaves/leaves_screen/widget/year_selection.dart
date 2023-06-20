import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/text_style.dart';
import '../../../../../data/configs/theme.dart';
import '../bloc/leaves/user_leave_bloc.dart';
import '../bloc/leaves/user_leave_event.dart';
import '../bloc/leaves/user_leave_state.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class YearSelection extends StatelessWidget {
  final DateTime dateOfJoining;

  const YearSelection({
    Key? key,
    required this.dateOfJoining,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppTheme.commonBorderRadius,
          boxShadow: AppTheme.commonBoxShadow),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 11),
              child: Text(AppLocalizations.of(context).year_tag,
                  style: AppFontStyle.bodyLarge)),
          BlocBuilder<UserLeaveBloc, UserLeaveState>(
            buildWhen: (previous, current) =>
                previous.selectedYear != current.selectedYear,
            builder: (context, state) => Container(
              height: 45,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.dividerColor),
              ),
              child: Material(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(12),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    style: AppFontStyle.bodySmallRegular,
                    isExpanded: true,
                    iconSize: 0.0,
                    icon: const SizedBox(),
                    borderRadius: BorderRadius.circular(12),
                    alignment: Alignment.center,
                    items: List.generate(
                        DateTime.now().year - (dateOfJoining.year - 1),
                        (change) =>
                            dateOfJoining.year + change).map((year) {
                      return DropdownMenuItem<int>(
                        alignment: Alignment.center,
                        value: year,
                        child: Text(year.toString()),
                      );
                    }).toList(),
                    value: state.selectedYear,
                    onChanged: (int? value) {
                      context.read<UserLeaveBloc>().add(
                          ChangeYearEvent(year: value ?? state.selectedYear));
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
