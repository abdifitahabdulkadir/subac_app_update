import 'package:flutter/material.dart';

class BuildListTilie extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  BuildListTilie({required this.leadingIcon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: ListTile(
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
          ),
          child: Icon(
            leadingIcon,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Icon(Icons.arrow_forward_ios_outlined),
      ),
    );
  }
}
