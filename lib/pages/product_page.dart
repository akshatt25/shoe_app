import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/providers/cart_provider.dart';

class ProductPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductPage({required this.product, super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late int selectedSize;
  @override
  void initState() {
    super.initState();
    selectedSize = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        title: const Text('Details'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.product['title'],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
              const Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  widget.product['imageUrl'],
                  height: 240,
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Text(
                '\$${widget.product['price']}',
                style: const TextStyle(fontSize: 35),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 38,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: (widget.product['sizes'] as List<int>).length,
                  itemBuilder: (context, index) {
                    int size = (widget.product['sizes'] as List<int>)[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        child: Chip(
                            side: selectedSize == size
                                ? BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary)
                                : const BorderSide(
                                    color: Color.fromARGB(42, 0, 0, 0)),
                            backgroundColor: selectedSize == size
                                ? Theme.of(context).colorScheme.primary
                                : const Color.fromARGB(0, 148, 23, 23),
                            label: Text(
                              '$size',
                              style: const TextStyle(fontSize: 15),
                            )),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Color.fromARGB(147, 0, 0, 0),
                ),
                style: ButtonStyle(
                    fixedSize: const MaterialStatePropertyAll(Size(300, 50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            30.0), // Adjust the radius as needed
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.primary)),
                onPressed: () {
                  if (selectedSize != 0) {
                    Provider.of<CartProvider>(context, listen: false)
                        .addProduct({
                      'id': widget.product['id'],
                      'title': widget.product['title'],
                      'price': widget.product['price'],
                      'imageUrl': widget.product['imageUrl'],
                      'company': widget.product['company'],
                      'size': selectedSize,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Added to Cart'),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please Select a Size'),
                    ));
                  }
                },
                label: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
