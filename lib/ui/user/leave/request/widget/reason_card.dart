import 'package:flutter/material.dart';

import '../../../../../configs/colors.dart';
import '../../../../../utils/const/other_constant.dart';

class ReasonCard extends StatefulWidget {
  TextEditingController controller;

  ReasonCard({Key? key, required this.controller}) : super(key: key);

  @override
  State<ReasonCard> createState() => _ReasonCardState();
}

class _ReasonCardState extends State<ReasonCard> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextFormField(
          style: const TextStyle(
              color: Colors.black87, fontSize: kLeaveRequestFontSize),
          cursorColor: AppColors.peachColor,
          maxLines: 5,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Reason',
            hintStyle:
                TextStyle(color: Colors.grey, fontSize: kLeaveRequestFontSize),
          ),
          autofocus: true,
          controller: _controller,
          keyboardType: TextInputType.text,
          onChanged: (data) {},
        ),
      )),
    );
  }
}
