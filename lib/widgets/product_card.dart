import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final String assetImage;
  const ProductCard(
      {required this.title,
      required this.price,
      required this.assetImage,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 214, 243, 246),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            '\$$price',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          SizedBox(
              height: 175,
              width: double.infinity,
              child: Image(image: AssetImage(assetImage)))
        ],
      ),
    );
  }
}
