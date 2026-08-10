import 'package:flutter/material.dart';
import 'package:orderable/api/api_service.dart';
import 'package:orderable/component/loading_indicator.dart';

class ProductDetailScreen extends StatefulWidget {
  int productId;
  ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
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
        centerTitle: true,
        title: Text("Food Detail",style: TextStyle(fontWeight: .bold),),
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
          final data = snapshot.data!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: .start,
                mainAxisAlignment: .center,
                children: [
                  Center(child: Image.network(data['thumbnail'])),

                  Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      data['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.star),
                      Text("${data['rating']}"),
                      SizedBox(width: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          "\$ ${data['price'].toString()}",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.black),

                  Text(
                    "Description",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(data['description']),
                  Text('₹${data['price']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


/*

crossAxisAlignment: .start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 270,
                  width: 350,
                  child: Image.asset("sgj", color: Colors.red),
                ),
              ),

              Text("Product name", style: TextStyle(fontWeight: .bold)),
              Text("rating"),
              Row(
                children: [
                  Text("pricing"),
                  Text("before discount"),
                  Text("discount"),
                ],
              ),
              Text("highlights"),

              Row(
                children: [
                  // GridView.builder(
                  //   itemCount: 15,
                  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                  //     crossAxisCount: 3,
                  //   ),
                  //   itemBuilder: ((context, index) => Container(
                  //     color: Colors.amber,
                  //     margin: EdgeInsets.all(10),
                  //   )),
                  // ),
                  ElevatedButton(onPressed: () {}, child: Text("Add to Cart")),
                  ElevatedButton(onPressed: () {}, child: Text("Buy Now")),


*/