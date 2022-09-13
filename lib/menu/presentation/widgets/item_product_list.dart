import 'package:ariztia_app/menu/data/models/product_model.dart';
import 'package:flutter/material.dart';

class ItemProductList extends StatelessWidget {
  const ItemProductList({Key? key, required this.product}) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 7,
                      color: Colors.black12,
                      offset: Offset(0, 4))
                ]),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                const SizedBox(width: 150),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name),
                    Text(product.price.toString()),
                    Expanded(child: Text(product.description.toString()))
                  ],
                )),
              ],
            ),
            height: 100,
            width: double.infinity,
          ),
          Positioned(
            left: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                product.photo,
                fit: BoxFit.cover,
              ),
            ),
            height: 120,
            width: 150,
          ),
        ],
      ),
    );
  }
}
