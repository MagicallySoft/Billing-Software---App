import 'package:flutter/material.dart';

import '../../../colors/colours.dart';

class Parties extends StatelessWidget {
  const Parties({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,

      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: white),
        ),
        backgroundColor: black,
        title: Text("Parties", style: TextStyle(color: white)),
      ),
      body: Center(child: Text("Coming soon", style: TextStyle(color: white))),
    );
  }
}
