import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: Text(
          "Order Status",
          style: TextStyle(color: Colors.white, fontWeight: .bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          Center(
            child: Text(
              "Your Order is Placed",
              style: TextStyle(fontWeight: .bold, fontSize: 25),
            ),
          ),
            Text(
            "Thank You For Choosing Us.❤️",
            style: TextStyle(fontWeight: .w500, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
