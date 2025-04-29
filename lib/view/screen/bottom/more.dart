import 'package:flutter/material.dart';
import 'package:invoice_generator/colors/colours.dart';

class More extends StatelessWidget {
  const More({super.key});

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
        title: Text("More", style: TextStyle(color: white)),
      ),
      body: Center(child: Text("Coming soon", style: TextStyle(color: white))),
    );
  }
}
