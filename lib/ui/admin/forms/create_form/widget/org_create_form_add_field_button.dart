import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/configs/colors.dart';
import '../../../../../data/configs/theme.dart';
import '../bloc/create_form_bloc.dart';
import '../bloc/create_form_event.dart';

class CreateOrgFormAddFieldButton extends StatelessWidget {
  const CreateOrgFormAddFieldButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateFormBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: AppTheme.commonBorderRadius,
          ),
          child: Row(
            children: [
              IconButton(
                  onPressed: () => bloc.add(AddFieldEvent()),
                  icon: const Icon(Icons.add_rounded)),
              IconButton(
                  onPressed: () => bloc.add(AddFieldImageEvent()),
                  icon: const Icon(Icons.image_outlined))
            ],
          ),
        )
      ],
    );
  }
}
