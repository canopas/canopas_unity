import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:projectunity/configs/colors.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/const/space_constant.dart';
import 'package:projectunity/widget/error_snack_bar.dart';
import '../../../../configs/font_size.dart';
import '../../../../di/service_locator.dart';
import '../../../../widget/circular_progress_indicator.dart';
import 'bloc/admin_setting_update_leave_count_screen_bloc.dart';
import 'bloc/admin_setting_update_leave_count_screen_event.dart';
import 'bloc/admin_setting_update_leave_count_screen_state.dart';
import 'bloc/admin_setting_update_paid_leave_button_state_bloc.dart';
import 'bloc/admin_setting_update_paid_leave_button_state_event.dart';


class AdminUpdateLeaveCountsPage extends StatelessWidget {
  const AdminUpdateLeaveCountsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<AdminSettingUpdatePaidLeaveCountBloc>()..add(AdminSettingPaidLeaveCountInitialLoadEvent()),
          ),
          BlocProvider(
            create: (_) => getIt<AdminPaidLeaveUpdateSettingTextFieldBloc>(),
          ),
        ],

        child: const AdminUpdateLeaveCountsScreen(),
    );
  }
}


class AdminUpdateLeaveCountsScreen extends StatefulWidget {
  const AdminUpdateLeaveCountsScreen({Key? key}) : super(key: key);

  @override
  State<AdminUpdateLeaveCountsScreen> createState() =>
      _AdminUpdateLeaveCountsScreenState();
}

class _AdminUpdateLeaveCountsScreenState
    extends State<AdminUpdateLeaveCountsScreen> {

  final TextEditingController _allLeaveCountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        foregroundColor: AppColors.blackColor,
      ),
      body: BlocListener<AdminSettingUpdatePaidLeaveCountBloc,AdminSettingUpdateLeaveCountState>(
        listener: (context, state) => {
          if(state is AdminSettingUpdateLeaveCountSuccessState){
            _allLeaveCountController.text = state.paidLeaveCount.toString()
          } else if(state is AdminSettingUpdateLeaveCountFailureState){
            showSnackBar(context: context,error: state.error)
          }else if (state is AdminSettingLeavesUpdatedState){
            context.pop()
          }
        },
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(30),
          children: [
            Text(
              localizations.settings_setting_text,
              style: AppTextStyle.largeHeaderBold,
            ),
            const SizedBox(
              height: primaryVerticalSpacing,
            ),
            Text(
              localizations.admin_total_yearly_paid_leave_text,
              style: AppTextStyle.settingSubTitle.copyWith(fontSize: subTitleTextSize),
            ),
            const SizedBox(
              height: primaryHorizontalSpacing,
            ),
            TextField(
              onChanged: (val){
                context.read<AdminPaidLeaveUpdateSettingTextFieldBloc>().add(PaidLeaveTextFieldChangeValueEvent(value: val));
              },
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: _allLeaveCountController,
              cursorColor: Colors.black,
              style: AppTextStyle.subtitleTextDark,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintStyle: AppTextStyle.secondarySubtitle500,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: localizations.total_paid_leaves,
              ),
            ),
            const SizedBox(
              height: primaryHorizontalSpacing,
            ),
            BlocBuilder<AdminSettingUpdatePaidLeaveCountBloc,AdminSettingUpdateLeaveCountState>(
                builder: (context, state) {
                  if(state is AdminSettingUpdateLeaveCountLoadingState){
                    return const AppCircularProgressIndicator();
                  }
                  return BlocBuilder<AdminPaidLeaveUpdateSettingTextFieldBloc,String>(
                    builder: (context, state) => ElevatedButton(
                        onPressed: state.isNotEmpty? ()  {
                          context.read<AdminSettingUpdatePaidLeaveCountBloc>().add(UpdatePaidLeaveCountEvent(leaveCount: _allLeaveCountController.text));
                        } : null,
                        child: Text(
                          AppLocalizations.of(context).update_button_text,
                          style: AppTextStyle.subtitleText,
                        )),
                  );
                },
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.whiteColor,
    );
  }

}
