import 'package:ariztia_app/menu/data/models/product_model.dart';
import 'package:ariztia_app/menu/presentation/bloc/shop_bloc/shop_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.product}) : super(key: key);
  final ProductModel product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int amount = 1;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final ShopBloc shopBloc = BlocProvider.of<ShopBloc>(context, listen: true);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imageProduct(size),
          _amountProduct(),
          _titleProcuct(),
          _description(),
          _options(),
          _btnAgregarProducto(size, shopBloc)
        ],
      ),
    );
  }

  InkWell _btnAgregarProducto(Size size, ShopBloc shopBloc) {
    return InkWell(
      onTap: () {
        shopBloc.add(ShopAddProductEvent([
          ...shopBloc.state.listProductShop,
          ProductShop(amount, widget.product)
        ]));
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.5),
          color: Colors.red[900],
        ),
        width: size.width,
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: const Text(
          'Agregar Producto',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Expanded _options() {
    print(widget.product.options);
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: widget.product.options
              .map(
                (Options e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.title,
                        style: TextStyle(
                          color: Colors.red[700],
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Wrap(
                        children: e.optionsItems
                            .map((ItemOptions item) => InkWell(
                                  onTap: () {
                                    if (e.quantity == 1) {
                                      e.optionsItems.forEach((element) {
                                        element.isSelect = false;
                                      });
                                    }
                                    item.isSelect = !item.isSelect;
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: item.isSelect
                                          ? Colors.green[200]
                                          : Colors.grey[200],
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 3),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    child: Text(
                                      item.name,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ))
                            .toList(),
                      )
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Padding _description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Text(widget.product.description.toString()),
    );
  }

  Container _titleProcuct() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.product.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          Text(
            widget.product.price.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const Text(
            'Bs.',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Row _amountProduct() {
    return Row(
      children: [
        Expanded(child: Container()),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey[300],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  amount = amount > 1 ? amount - 1 : amount;
                  setState(() {});
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.remove),
                ),
              ),
              Text('$amount'),
              InkWell(
                onTap: () {
                  amount = amount + 1;
                  setState(() {});
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }

  Widget _imageProduct(Size size) {
    return Hero(
      tag: widget.product.idProduct,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: CachedNetworkImage(
            imageUrl: widget.product.photo,
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
            width: size.width,
            height: size.width,
          )
          // Image.network(
          //   widget.product.photo,
          //   fit: BoxFit.cover,
          // ),
          ),
    );
  }
}
