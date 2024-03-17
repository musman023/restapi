// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class RowWidget extends StatelessWidget {
  String title, value;
  RowWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
