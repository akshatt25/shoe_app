import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartList = Provider.of<CartProvider>(context).getSavedCartItems();
    // debugPrint(Provider.of<CartProvider>(context).cart.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        toolbarHeight: 75,
      ),
      body: ListView.builder(
          itemCount: cartList.length,
          itemBuilder: (context, index) {
            final cartItem = cartList[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black12,
                backgroundImage: AssetImage(cartItem['imageUrl'] as String),
              ),
              title: Text(
                cartItem['title'] as String,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              subtitle: Text('Size: ${cartItem['size']}'),
              trailing: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              'Are you sure',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            content: const Text(
                                'Are you sure you want to remove this item from cart?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    context
                                        .read<CartProvider>()
                                        .removeProduct(cartItem);

                                    // Provider.of<CartProvider>(context,
                                    //         listen: false)
                                    //     .removeProduct(cartItem);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.red),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'No',
                                    style: TextStyle(color: Colors.blue),
                                  )),
                            ],
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 25,
                    color: Color.fromARGB(217, 230, 49, 36),
                  )),
            );
          }),
    );
  }
}
