import 'package:flutter/material.dart';
import 'package:projectunity/data/configs/text_style.dart';
import 'package:projectunity/data/configs/theme.dart';
import '../../../data/configs/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SpaceScreen extends StatefulWidget {
  const SpaceScreen({Key? key}) : super(key: key);

  @override
  State<SpaceScreen> createState() => _SpaceScreenState();
}

class _SpaceScreenState extends State<SpaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).space_list_screen_title),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext context, int index) =>
            SpaceCard(onPressed: () {
          ///TODO: Add Implementation for Space Card Tap Event
        }),
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: 2,
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 45)),
        onPressed: () {
          ///TODO: Add Implementation for Create New Space
        },
        child: Text(AppLocalizations.of(context).create_space_button_text),
      ),
    );
  }
}

class SpaceCard extends StatelessWidget {
  final void Function()? onPressed;
  final String? imageURL;

  const SpaceCard({Key? key, this.onPressed,  this.imageURL }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: AppTheme.commonBorderRadius,
        boxShadow: AppTheme.commonBoxShadow,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppTheme.commonBorderRadius,
        child: InkWell(
          borderRadius: AppTheme.commonBorderRadius,
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: imageURL == null?AppColors.textFieldBg:AppColors.whiteColor,
                      borderRadius: AppTheme.commonBorderRadius,
                      image: imageURL == null
                          ? null
                          : DecorationImage(
                        image: NetworkImage(imageURL!),
                        fit: BoxFit.cover,
                      )),
                  child: imageURL != null
                      ? null
                      : const Icon(Icons.business,
                      color: AppColors.secondaryText, size: 40),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).company_name,
                        style: AppFontStyle.bodyLarge
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const Text("24 Members", style: AppFontStyle.subTitleGrey)
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
