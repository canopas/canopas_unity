import 'package:flutter/material.dart';
import 'package:projectunity/configs/font_size.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, right: 30, left: 30),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 45,
      decoration: ShapeDecoration(
          shape: const StadiumBorder(), color: Colors.grey.shade200),
      child: Row(
        children: const [
          Icon(
            Icons.search,
            color: Colors.grey,
            size: 26,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              cursorColor: Colors.black54,
              style: TextStyle(fontSize: titleTextSize, color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 13),
                  hintText: 'Search your Colleagues by name',
                  hintStyle: TextStyle(fontSize: 17)),
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              textAlignVertical: TextAlignVertical.center,
            ),
          ),
        ],
      ),
    );
  }
}
