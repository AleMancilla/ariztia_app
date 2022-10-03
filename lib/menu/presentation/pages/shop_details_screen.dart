import 'dart:convert';

import 'package:ariztia_app/core/constants/api_firebase_constant.dart';
import 'package:ariztia_app/core/utils.dart';
import 'package:ariztia_app/menu/presentation/bloc/shop_bloc/shop_bloc.dart';
import 'package:ariztia_app/menu/presentation/pages/order_complete.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge_alert/edge_alert.dart';
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
    final ShopBloc shopBloc = BlocProvider.of<ShopBloc>(context, listen: true);
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
                              padding: const EdgeInsets.only(
                                  left: 15, top: 10, right: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: SizedBox(
                                  child: CachedNetworkImage(
                                    imageUrl: productShop.product.photo,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  ),
                                  width: 50,
                                  height: 50,
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
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    'Bs. ${productShop.product.price}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            _amountProduct(productShop),
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
                        ? 'Ingresa el Nº de mesa'
                        : 'Ingresa tu número de whatsapp',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      controller: controllertype,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Razón social o Apellido',
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
                    'CI o NIT',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
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
        if (controllertype.text.isEmpty) {
          showValidateSnackVar('Campo requerido', 'Debe ingresar el numero');
          return;
        }
        if (controllerRazonSocial.text.isEmpty) {
          showValidateSnackVar(
              'Campo requerido', 'Debe ingresar la Razon social o el Apellido');
          return;
        }
        if (controllerCi.text.isEmpty) {
          showValidateSnackVar('Campo requerido', 'Debe ingresar CI o NIT');
          return;
        }
        List<ProductShop> listToSend = shopBloc.state.listProductShop;
        List<Map<String, dynamic>> _listToSend =
            listToSend.map((e) => e.toJson()).toList();
        try {
          Map<String, dynamic> toSend = {
            'list_orders': _listToSend,
            'razon_social': controllerRazonSocial.text,
            'ci_nit': controllerCi.text,
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

  showValidateSnackVar(String title, String description) {
    EdgeAlert.show(context,
        title: title,
        description: description,
        gravity: EdgeAlert.TOP,
        backgroundColor: Colors.red[900],
        icon: Icons.error_outline);
  }

  _getTotalPrice(ShopBloc shopBloc) {
    double amountTotal = 0;
    shopBloc.state.listProductShop.forEach((element) {
      amountTotal = amountTotal + (element.product.price * element.amount);
    });
    return amountTotal;
  }

  Container _amountProduct(ProductShop product) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        // color: Colors.grey[300],
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // InkWell(
          //   onTap: () {
          //     amount = amount > 1 ? amount - 1 : amount;
          //     setState(() {});
          //   },
          //   child: const Padding(
          //     padding: EdgeInsets.all(8.0),
          //     child: Icon(Icons.remove),
          //   ),
          // ),
          Text(
            ' x${product.amount} ',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.red[900]),
          ),
          Text(
            ' Bs. ${product.product.price * product.amount} ',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
          ),
          Material(
            child: InkWell(
              onTap: () {
                // amount = amount + 1;
                // setState(() {});
                final ShopBloc shopBloc =
                    BlocProvider.of<ShopBloc>(context, listen: false);

                List<ProductShop> newList = shopBloc.state.listProductShop;
                newList.remove(product);
                shopBloc.add(ShopAddProductEvent(newList));
              },
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: Colors.black26),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
