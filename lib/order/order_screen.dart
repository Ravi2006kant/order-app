import 'package:flutter/material.dart';
import 'package:orderable/order/order_management.dart';
import 'package:orderable/order/summary_screen.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text(
          "Your Order",
          style: TextStyle(color: Colors.white, fontWeight: .bold),
        ),
      ),

      body: SafeArea(
        child: AnimatedBuilder(
          animation: orderManager,
          builder: (context, _) {
            if (orderManager.items.isEmpty) {
              return const Center(
                child: Text(
                  "No items in your order",
                  style: TextStyle(fontWeight: .bold, fontSize: 20),
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
                        color: Colors.white,
                        elevation: 2,
                        child: Row(
                          children: [
                            Image.network(
                              item.image,
                              width: 100,
                              height: 100,
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
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 15),

                                  Row(
                                    mainAxisAlignment: .spaceBetween,
                                    crossAxisAlignment: .end,
                                    children: [
                                      Row(
                                        children: [
                                          Center(
                                            child: IconButton(
                                              style: ButtonStyle(),
                                              onPressed: () {
                                                orderManager.decreaseQuantity(
                                                  item,
                                                );
                                              },
                                              icon: const Icon(Icons.remove),
                                            ),
                                          ),

                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor:
                                                Colors.orangeAccent,
                                            child: Text(
                                              "${item.quantity}",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),

                                          IconButton(
                                            // style: ButtonStyle(
                                            //   backgroundColor: WidgetStatePropertyAll(
                                            //     Colors.orangeAccent,
                                            //   ),
                                            // ),
                                            onPressed: () {
                                              orderManager.increaseQuantity(
                                                item,
                                              );
                                            },
                                            icon: const Icon(Icons.add),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    top: 10,
                                    bottom: 15,
                                  ),
                                  child: Text(
                                    "₹${item.price}",
                                    style: TextStyle(
                                      fontWeight: .w900,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    orderManager.removeItem(item);
                                  },
                                  icon: const Icon(
                                    Icons.delete_rounded,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
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
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Text(
                            "PRICE:",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            "₹${orderManager.total.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                  
                      const SizedBox(height: 10),
                  
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.orange.shade700,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SummaryScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "PLACE ORDER",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: .bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
