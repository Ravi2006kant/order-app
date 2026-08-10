import 'package:flutter/material.dart';
import 'order_item.dart';

class OrderManager extends ChangeNotifier {
  OrderManager._();

  static final OrderManager instance = OrderManager._();

  final List<OrderItem> items = [];

  void addItem(Map<String, dynamic> product) {
    final id = product['id'];

    final existingIndex = items.indexWhere(
      (item) => item.id == id,
    );

    if (existingIndex != -1) {
      items[existingIndex].quantity++;
    } else {
      items.add(
        OrderItem(
          id: id,
          name: product['title'],
          image: product['thumbnail'],
          price: (product['price'] as num).toDouble(),
        ),
      );
    }

    notifyListeners();
  }

  void increaseQuantity(OrderItem item) {
    item.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(OrderItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      items.remove(item);
    }

    notifyListeners();
  }

  void removeItem(OrderItem item) {
    items.remove(item);
    notifyListeners();
  }

  double get total {
    double total = 0;

    for (final item in items) {
      total += item.price * item.quantity;
    }

    return total;
  }

  void clearOrder() {
    items.clear();
    notifyListeners();
  }
}