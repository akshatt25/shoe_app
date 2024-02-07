import 'package:flutter/material.dart';
import 'package:shoe_app/widgets/product_card.dart';
import 'package:shoe_app/pages/product_page.dart';
import 'package:shoe_app/products_cart.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = ['All', 'Adidas', 'Nike', 'Reebok', 'Puma'];
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder out = const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black26),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60), bottomLeft: Radius.circular(60)),
    );
    return SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding:
                    EdgeInsets.only(top: 40, bottom: 35, left: 25, right: 30),
                child: Text(
                  'Shoes\nCollection',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 30),
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12.5),
                    hintText: 'Search',
                    enabledBorder: out,
                    focusedBorder: out,
                    prefixIcon: const Icon(
                      Icons.search,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 80,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (BuildContext context, int index) {
                  final filter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filter;
                        });
                      },
                      child: Chip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0), // Adjust the radius as needed
                        ),
                        side: BorderSide(color: Colors.transparent),
                        backgroundColor: selectedFilter == filter
                            ? Theme.of(context).colorScheme.primary
                            : const Color.fromRGBO(245, 247, 249, 1),
                        label: Text(filter),
                        labelStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 17.5, vertical: 12.5),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return ProductPage(product: products[index]);
                      }),
                    );
                  },
                  child: ProductCard(
                    title: products[index]['title'] as String,
                    price: products[index]['price'] as double,
                    assetImage: products[index]['imageUrl'] as String,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
