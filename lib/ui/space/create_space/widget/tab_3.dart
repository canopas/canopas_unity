import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/configs/text_style.dart';
import '../../../../data/core/utils/bloc_status.dart';
import '../../../navigation/app_router.dart';
import '../../../widget/employee_details_textfield.dart';
import '../../../widget/error_snack_bar.dart';
import '../bloc/create_workspace_bloc.dart';
import '../bloc/create_workspace_event.dart';
import '../bloc/create_workspace_state.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo>
    with AutomaticKeepAliveClientMixin {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.text = context.read<CreateSpaceBLoc>().state.ownerName ?? "";
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bloc = BlocProvider.of<CreateSpaceBLoc>(context);
    final locale = AppLocalizations.of(context);
    return SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: BlocListener<CreateSpaceBLoc, CreateSpaceState>(
            listenWhen: (previous, current) =>
                current.createSpaceStatus == Status.error ||
                current.createSpaceStatus == Status.success,
            listener: (context, state) {
              if (state.createSpaceStatus == Status.error) {
                showSnackBar(context: context, error: state.error);
              }
              if (state.createSpaceStatus == Status.success) {
                context.goNamed(Routes.adminHome);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locale.create_space_enter_your_details_text,
                  style: AppFontStyle.titleDark,
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<CreateSpaceBLoc, CreateSpaceState>(
                    buildWhen: (previous,current)=>previous.ownerName!= current.ownerName,
                    builder: (context, state) {
                      return FieldEntry(
                        hintText: state.ownerName??locale.create_space_enter_your_name_hint_text,
                        controller: controller,
                        keyboardType: TextInputType.name,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                        onChanged: (String? value) {
                          bloc.add(UserNameChangeEvent(name: value));
                        },
                        errorText: state.ownerNameError
                            ? locale.create_space_invalid_name_error
                            : null,
                      );
                    }),
              ],
            )));
  }

  @override
  bool get wantKeepAlive => true;
}
