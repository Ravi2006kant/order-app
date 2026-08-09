import 'package:flutter/material.dart';
import 'package:orderable/api/api_service.dart';
import 'package:orderable/component/loading_indicator.dart';
import 'package:orderable/screen/product_detail_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text(
          "Order",
          style: TextStyle(color: Colors.white, fontWeight: .bold),
        ),
      ),
      body: FutureBuilder(
        future: apiService.getProducts(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingIndicator();
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final products = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          productId: products[index]['id'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.network(
                            products[index]['images'][0],
                            width: 100,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              ListTile(
                                title: Text(products[index]['title']),
                                trailing: Icon(Icons.favorite),
                              ),
                              Row(
                                children: [
                                  Text(products[index]['price'].toString()),
                                  const SizedBox(width: 25),
                                  Text(
                                    products[index]['discountPercentage']
                                        .toString(),
                                  ),
                                ],
                              ),
                              Text(products[index]['category']),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

/*

image 
title
description
price
rating
brand
category


*/
