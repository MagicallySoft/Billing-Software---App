import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../../../colors/colours.dart';

class NotesTerms extends StatelessWidget {
  const NotesTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: white),
          ),
          backgroundColor: black,
          bottom: TabBar(
            labelColor: white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: white,
            tabs: const [Tab(text: "Notes"), Tab(text: "Terms")],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Text("Notes coming soon", style: TextStyle(color: white)),
            ),

            ///-------------------------------------TabView------------------------------------------///
            Center(
              child: Text("Terms coming soon", style: TextStyle(color: white)),
            ),
          ],
        ),
      ),
    );
  }
}
