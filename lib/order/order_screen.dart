import 'package:flutter/material.dart';
import 'package:orderable/order/order_management.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final orderManager = OrderManager.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: Text(
          "Your Order",
          style: TextStyle(color: Colors.white, fontWeight: .bold),
        ),
      ),

      body: AnimatedBuilder(
        animation: orderManager,
        builder: (context, _) {
          if (orderManager.items.isEmpty) {
            return const Center(
              child: Text(
                "No items in your order",
                style: TextStyle(fontWeight: .bold),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: orderManager.items.length,
                  itemBuilder: (context, index) {
                    final item = orderManager.items[index];

                    return Card(
                      child: Row(
                        children: [
                          Image.network(
                            item.image,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Text("₹${item.price}"),

                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        orderManager.decreaseQuantity(item);
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),

                                    Text("${item.quantity}"),

                                    IconButton(
                                      onPressed: () {
                                        orderManager.increaseQuantity(item);
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              orderManager.removeItem(item);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Total: ₹${orderManager.total.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("PLACE ORDER"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
