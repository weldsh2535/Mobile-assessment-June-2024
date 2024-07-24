import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final Function removeItem;
  final Function? updateItemQuantity;

  const CartItemWidget({super.key, required this.cartItem, required this.removeItem, this.updateItemQuantity});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      background: Container(
        color: Theme.of(context).indicatorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        removeItem(cartItem.id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: cartItem.image!,
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
            title: Text(cartItem.title),
            subtitle: Row(
              children: [
                Text('Total: \$${cartItem.price * cartItem.quantity}'),
                SizedBox(width: MediaQuery.of(context).size.width *.04,),
                Text('Quantity: ${cartItem.quantity} x')
              ],
            ),
            trailing: GestureDetector(
              onTap: () {
                  if (cartItem.quantity > 1) {
                      removeItem(cartItem.id, cartItem.quantity - 1);
                    } else {
                      removeItem(cartItem.id);
                    }
              },
              child: Icon(Icons.remove_circle)),
          ),
        ),
      ),
    );
  }
}
