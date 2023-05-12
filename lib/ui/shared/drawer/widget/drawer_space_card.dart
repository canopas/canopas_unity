import 'package:flutter/material.dart';
import '../../../../data/configs/text_style.dart';
import '../../../../data/configs/theme.dart';
import '../../../widget/space_logo_view.dart';

class DrawerSpaceCard extends StatelessWidget {
  final String name;
  final String? logo;
  final Function()? onTap;

  const DrawerSpaceCard({Key? key, required this.name, this.logo, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppTheme.commonBorderRadius,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            SpaceLogoView(size: 45, spaceLogo: logo),
            const SizedBox(width: 10),
            Flexible(
                child: Text(name,
                    style: AppFontStyle.bodyLarge,
                    overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
    );
  }
}
