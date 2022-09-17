import 'dart:convert';

import 'package:ariztia_app/core/constants/api_firebase_constant.dart';
import 'package:ariztia_app/core/utils.dart';
import 'package:ariztia_app/menu/presentation/bloc/shop_bloc/shop_bloc.dart';
import 'package:ariztia_app/menu/presentation/pages/order_complete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopDetailsScreen extends StatefulWidget {
  const ShopDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  TextEditingController controllerRazonSocial = TextEditingController();
  TextEditingController controllertype = TextEditingController();
  TextEditingController controllerCi = TextEditingController();
  String typeOrder = 'Mesa';
  @override
  Widget build(BuildContext context) {
    final ShopBloc shopBloc = BlocProvider.of<ShopBloc>(context, listen: false);
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Text('Detalle de compra',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: shopBloc.state.listProductShop
                      .map(
                        (ProductShop productShop) => Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: SizedBox(
                                  child: Image.network(
                                    productShop.product.photo,
                                    fit: BoxFit.cover,
                                  ),
                                  width: 65,
                                  height: 65,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productShop.product.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text('Bs. ${productShop.product.price}'),
                                ],
                              ),
                            ),
                            _amountProduct(productShop.amount),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Bs. ${_getTotalPrice(shopBloc)}',
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 25,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Row(
                        children: [
                          _radioButton('Mesa'),
                          const SizedBox(width: 10),
                          _radioButton('Para llevar'),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    typeOrder == 'Mesa'
                        ? 'Ingresa el nro de mesa'
                        : 'Ingresa tu numer de whatsapp',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: controllertype,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Razon social o Apellido',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: controllerRazonSocial,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Ci o Nit',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: controllerCi,
                    ),
                  ),
                  SizedBox(height: 20),
                  _btnEnviarPedido(size, shopBloc),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _radioButton(String title) {
    bool isSelect = (typeOrder == title);
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
        InkWell(
          onTap: () {
            typeOrder = title;
            setState(() {});
          },
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelect ? Colors.red[800] : Colors.grey,
            ),
            child: Padding(
              padding: EdgeInsets.all(3),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: isSelect
                    ? Padding(
                        padding: EdgeInsets.all(5),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelect ? Colors.red[800] : Colors.grey,
                          ),
                        ),
                      )
                    : Container(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  InkWell _btnEnviarPedido(Size size, ShopBloc shopBloc) {
    return InkWell(
      onTap: () {
        List<ProductShop> listToSend = shopBloc.state.listProductShop;
        List<Map<String, dynamic>> _listToSend =
            listToSend.map((e) => e.toJson()).toList();
        try {
          Map<String, dynamic> toSend = {
            'list_orders': _listToSend,
            'razon_social': controllerRazonSocial.text,
            'ci_nit': controllerCi,
            'type_order': typeOrder,
            'info_order': controllertype.text,
          };
          print(toSend);
          print('_____________________');
          ariztiaOrders
              .add(toSend)
              .then((value) => print("order Added"))
              .catchError((error) => print("Failed to add order: $error"));
        } catch (e) {
          print('========> $e');
        }
        navigateToPageAndRemove(context, OrderComplete());
        shopBloc.add(ShopAddProductEvent([]));
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
          'Enviar Pedido',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  _getTotalPrice(ShopBloc shopBloc) {
    double amountTotal = 0;
    shopBloc.state.listProductShop.forEach((element) {
      amountTotal = amountTotal + (element.product.price * element.amount);
    });
    return amountTotal;
  }

  Container _amountProduct(int amount) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
    );
  }
}
