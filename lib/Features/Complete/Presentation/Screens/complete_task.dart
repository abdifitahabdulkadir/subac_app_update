import 'package:flutter/material.dart';

// my imports
import '../../../core/Widgets/icon_design.dart';

class CompeleteTask extends StatelessWidget {
  static final String routeName = "/completeTask";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text(
          "Complete",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        elevation: 0,
        leading: BackButton(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            height: 400,
            width: 400,
            child: Image.asset("lib/core/images/comp.png"),
          ),
          Text("Resume"),
          Padding(
            padding: EdgeInsets.all(6),
            child: Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 49, 202, 169),
              ),
              child: Center(child: Text("Audio will be here ")),
            ),
          ),
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ContainerIconHolder(
              containerBackground: Colors.red,
              buttonBackgroundColor: Colors.white,
              typeIcon: Icons.pause,
            ),
            SizedBox(width: 50),
            ContainerIconHolder(
              containerBackground: Color.fromARGB(255, 49, 202, 169),
              buttonBackgroundColor: Colors.white,
              typeIcon: Icons.stop,
            ),
          ]),
        ],
      ),
    );
  }
}
