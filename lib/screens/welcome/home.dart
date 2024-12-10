import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("E-Ticketing")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                
              },
              child: Text("Book Ticket"),
            ),
            ElevatedButton(
              onPressed: () {
                
              },
              child: Text("View Ticket"),
            ),
          ],
        ),
      ),
    );
  }
}
