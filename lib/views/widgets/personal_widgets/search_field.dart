// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medica/config/config.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(12, 8, 8, 8),
          height: 60,
          width: 300,
          child: TextField(
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              hintText: 'Search For A Doctor',
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: Config.primaryColor.shade100,
              borderRadius: BorderRadius.circular(8)),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ),
      ],
    );
  }
}
