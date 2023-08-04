import 'package:flutter/material.dart';

class CompeleteTask extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 600,
          width: 400,
          child: Image.asset("lib/core/images/comp.png"),
        ),
        Text(
          "No more Paused Subac is available now",
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: 15,
              ),
        )
      ],
    );
  }
}
