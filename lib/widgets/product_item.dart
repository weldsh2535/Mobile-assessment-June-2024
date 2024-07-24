import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/product/product.dart';
import '../screens/product_detail.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderColor,width: 1)
        ),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: AppColors.balack12,
            title: Text(
              product.title!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.black),
            ),
          ),
          child:  CachedNetworkImage(
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
        ),
      ),
    );
  }
}
