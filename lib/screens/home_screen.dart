import 'package:flutter/material.dart';
import 'package:flutter_assessment/models/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product/product.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
    final List<dynamic> productData = json.decode(response.body);
    setState(() {
      _products = productData.map((json) => Product.fromMap(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
     final cart = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart,size: 30,),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ),
                  );
                },
              ),
              if (cart.itemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      cart.itemCount.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ]
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: RefreshIndicator(
            onRefresh: () async {
              await _fetchProducts();
            },
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: _products.length,
              itemBuilder: (ctx, i) => ProductItem(product: _products[i]),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
