import 'package:flutter/material.dart';
import 'package:orderable/component/bottombar.dart';
import 'package:orderable/order/order_screen.dart';
import 'package:orderable/screen/product_list_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> screen = [ProductListScreen(), OrderScreen()];
    return Scaffold(
      body: screen[_index],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange.shade700,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(fontWeight: .bold),
        type: .fixed,
        onTap: (inde) {
          setState(() {
            _index = inde;
          });
        },
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Order",
          ),
          // BottomNavigationBarItem(icon: Icon(Icons.more_horiz_outlined),label: "more"),
        ],
      ),
    );
  }
}
