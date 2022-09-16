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
                    Text(
                      product.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      product.price.toString(),
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.red),
                    ),
                    Expanded(child: Text(product.description.toString()))
                  ],
                )),
              ],
            ),
            height: 105,
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
          Positioned(
            right: -20,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(270 / 360),
              child: ClipPath(
                clipper: CustomClip(),
                child: Container(
                  width: 70,
                  height: 35,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          const Positioned(
            child: Icon(Icons.add, color: Colors.white),
            right: 0,
          )
        ],
      ),
    );
  }
}

class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 35;

    Path path = Path();
    path
      ..moveTo(size.width / 2, 0)
      ..arcToPoint(Offset(size.width, size.height),
          radius: Radius.circular(radius))
      ..lineTo(0, size.height)
      ..arcToPoint(
        Offset(size.width / 2, 0),
        radius: Radius.circular(radius),
      )
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
