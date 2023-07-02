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
            color: Colors.grey.withOpacity(0.30),
          ),
          child: Icon(
            leadingIcon,
            color: Color.fromARGB(255, 49, 202, 169),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios_outlined),
      ),
    );
  }
}
