import 'package:flutter/material.dart';

class Assembly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 350,
        child: Card(
          elevation: 0,
          color: Colors.grey.shade300,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Image(image: AssetImage("lib/core/images/kitab.png"), height: 50),
              SizedBox(height: 10),
              Text("Assembly"),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
