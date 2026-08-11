import 'package:flutter/material.dart';
import 'package:orderable/api/api_service.dart';
import 'package:orderable/component/loading_indicator.dart';
import 'package:orderable/order/order_management.dart';
import 'package:orderable/order/order_screen.dart';
import 'package:orderable/screen/product_detail_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(
          "Menu",
          style: TextStyle(color: Colors.white, fontWeight: .bold),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: apiService.getProducts(),

          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingIndicator();
            }

            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            final products = snapshot.data!;
            return ListView.builder(
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
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 7,
                      left: 7,
                      right: 7,
                      bottom: 0,
                    ),
                    child: Card(
                      elevation: 2,
                      color: Colors.orange.shade500,
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade500,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.network(
                                  products[index]['images'][0],
                                  width: 100,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: .start,
                                  children: [
                                    Text(
                                      products[index]['title'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: .bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      products[index]['description'],
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment: .spaceBetween,
                                      children: [
                                        Text(
                                          "\$ ${products[index]['price'].toString()}",
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontWeight: .w500,
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              OrderManager.instance.addItem(
                                                products[index],
                                              );
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  duration: Duration(
                                                    seconds: 1,
                                                  ),
                                                  content: Text(
                                                    products[index]['title'],
                                                  ),
                                                ),
                                              );
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         OrderScreen(),
                                              //   ),
                                              // );
                                            },

                                            child: Text(
                                              "Add",
                                              style: TextStyle(
                                                fontWeight: .bold,
                                                backgroundColor: Colors.white,
                                                color: Colors.orangeAccent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //     horizontal: 15,
                                    //   ),
                                    //   child: Text(
                                    //     "Discount - ${products[index]['discountPercentage'].toString()}%",
                                    //     style: TextStyle(
                                    //       color: Colors.white,
                                    //       // decoration: .lineThrough,
                                    //       // decorationThickness: 2,
                                    //       // decorationColor: Colors.white,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

/*
Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return OrderScreen(
                                            productId: products[index]['id'],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.add, color: Colors.amber),
                                ),
                              ),


*/
