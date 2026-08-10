import 'package:flutter/material.dart';
import 'package:orderable/api/api_service.dart';
import 'package:orderable/component/loading_indicator.dart';

class OrderScreen extends StatefulWidget {
  int productId;
  OrderScreen({super.key, required this.productId});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late Future<Map<String, dynamic>> product;

  @override
  void initState() {
    super.initState();
    product = ApiService().getProductById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.amber,
        title: Text("order list"),
      ),
      body: FutureBuilder(
        future: product,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingIndicator();
          }

          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          final products = snapshot.data!;

          return Container(
            height: 120,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image.network(products['thumbnail'], width: 100),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      ListTile(
                        title: Text(
                          products['title'],
                          style: TextStyle(fontWeight: .bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "\$ ${products['price'].toString()}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: .w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Discount - ${products['discountPercentage'].toString()}%",
                          style: TextStyle(
                            color: Colors.white,
                            // decoration: .lineThrough,
                            // decorationThickness: 2,
                            // decorationColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}



/*


     return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: products,

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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ProductDetailScreen(
                    //       productId: products[index]['id'],
                    //     ),
                    //   ),
                    // );
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
                                title: Text(
                                  products[index]['title'],
                                  style: TextStyle(fontWeight: .bold),
                                ),
                                trailing: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.add, color: Colors.amber),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Text(
                                  "\$ ${products[index]['price'].toString()}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: .w500,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Text(
                                  "Discount - ${products[index]['discountPercentage'].toString()}%",
                                  style: TextStyle(
                                    color: Colors.white,
                                    // decoration: .lineThrough,
                                    // decorationThickness: 2,
                                    // decorationColor: Colors.white,
                                  ),
                                ),
                              ),
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

*/


