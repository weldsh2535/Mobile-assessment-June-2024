import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/constants/colors.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../models/product/product.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
      final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(product.title!),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
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
        ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: product.image!,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                placeholder: (context, url) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.orange[900],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Getting item image",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.favorite,color: AppColors.black,),
                  const Icon(Icons.favorite,color: AppColors.black),
                  const Icon(Icons.favorite,color: AppColors.black),
                  const Icon(Icons.favorite,color: AppColors.balack12),
                  const Icon(Icons.favorite,color: AppColors.balack12),
                  Text(
                    '${product.rating!.rate}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '\$${product.price}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.description!,
                textAlign: TextAlign.justify,
                softWrap: true,
              ),
              const SizedBox(height: 10),
                GestureDetector(
                onTap: 
                () {
                Provider.of<Cart>(context, listen: false).addItem(product: product);
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:  AppColors.green),
                  child: const Center(
                      child: Text(
                    "Add to Cart",
                    style: TextStyle(color: AppColors.white),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
