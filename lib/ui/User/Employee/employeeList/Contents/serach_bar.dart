import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.only(top: 30, right: 30, left: 30),
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey.shade200),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: TextField(
          cursorColor: Colors.black54,
          style: GoogleFonts.ibmPlexSans(fontSize: 20, color: Colors.black87),
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              hintText: 'Search your Colleagues by name',
              hintStyle: height >= 700
                  ? const TextStyle(fontSize: 20)
                  : const TextStyle(fontSize: 16)),
          textAlign: TextAlign.start,
          keyboardType: TextInputType.text,
        ),
      ),
    );
  }
}
