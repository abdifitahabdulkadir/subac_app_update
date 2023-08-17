import 'package:flutter/material.dart';

class CategoryDesign extends StatelessWidget {
  final String title;

  CategoryDesign({required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(title),
    );
  }
}
