import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/ui/widget/space_logo_view.dart';

class OrgLogoView extends StatelessWidget {
  final void Function()? onButtonTap;

  final String? pickedLogoFile;

  const OrgLogoView({super.key, this.onButtonTap, this.pickedLogoFile});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: const Alignment(1.5, 1.5),
        children: [
          SpaceLogoView(size: 110, pickedLogoFile: pickedLogoFile),
          IconButton(
            style: IconButton.styleFrom(
                fixedSize: const Size(45, 45),
                side: BorderSide(
                    color: context.colorScheme.containerNormal, width: 3),
                backgroundColor: context.colorScheme.surface),
            onPressed: onButtonTap,
            icon: Icon(
              Icons.edit,
              size: 20,
              color: context.colorScheme.containerHigh,
            ),
          )
        ],
      ),
    );
  }
}
