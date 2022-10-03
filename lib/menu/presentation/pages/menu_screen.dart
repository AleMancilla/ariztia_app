import 'package:ariztia_app/core/utils.dart';
import 'package:ariztia_app/menu/data/models/product_model.dart';
import 'package:ariztia_app/menu/presentation/bloc/business_bloc/business_bloc.dart';
import 'package:ariztia_app/menu/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:ariztia_app/menu/presentation/bloc/products_bloc/products_bloc.dart';
import 'package:ariztia_app/menu/presentation/bloc/products_bloc/products_utils.dart';
import 'package:ariztia_app/menu/presentation/bloc/shop_bloc/shop_bloc.dart';
import 'package:ariztia_app/menu/presentation/pages/product_screen.dart';
import 'package:ariztia_app/menu/presentation/pages/shop_details_screen.dart';
import 'package:ariztia_app/menu/presentation/widgets/app_bar_ariztia.dart';
import 'package:ariztia_app/menu/presentation/widgets/categories_list.dart';
import 'package:ariztia_app/menu/presentation/widgets/item_product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<String> allCategories = [];
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final BusinessBloc businessBloc =
          BlocProvider.of<BusinessBloc>(context, listen: false);
      await chargeAllProducts(
        context,
        idBusinnes: businessBloc.state.idBusiness,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CategoryBloc categoryBloc =
        BlocProvider.of<CategoryBloc>(context, listen: true);
    final ShopBloc shopBloc = BlocProvider.of<ShopBloc>(context, listen: true);
    // final ProductsBloc productsBloc =
    //     BlocProvider.of<ProductsBloc>(context, listen: true);
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        primary: true,
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   Scrollable.ensureVisible(listGlobalKey[1].currentContext!);
        // }),
        body: Column(
          children: [
            const AppBarAriztia(),
            const SizedBox(height: 10),
            _categories(categoryBloc),
            const SizedBox(height: 10),
            _productByCategories(),
            if (shopBloc.state.listProductShop.isNotEmpty)
              _btnConfirmarPedido(size, shopBloc),
          ],
        ),
      ),
    );
  }

  Expanded _productByCategories() {
    return Expanded(
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoadState) {
            return const Text('cargando....');
          }
          if (state is ProductsFinalState) {
            print(state.listProduct);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: SingleChildScrollView(
                child: Column(
                  children: getProductsByCategory(state.listProduct),
                  // scrollDirection: Axis.vertical,
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  BlocBuilder<CategoryBloc, CategoryState> _categories(
      CategoryBloc categoryBloc) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        // categoryBloc.state.listCategories.sort((a, b) => a.compareTo(b));
        return CategoriesList(
          categoryBloc: categoryBloc,
          categories: categoryBloc.state.listCategories,
          changeCategory: (data) {
            //scrollea hasta donde corresponde
            Scrollable.ensureVisible(
                listGlobalKey[forValitation.indexOf(data)].currentContext!,
                duration: Duration(milliseconds: 500));
          },
        );
      },
    );
  }

  List<GlobalKey> listGlobalKey = [];
  List<String> forValitation = [];
  List<Widget> getProductsByCategory(List<ProductModel> listProducts) {
    listGlobalKey = [];
    forValitation = [];
    List<Widget> listToReturn = [];
    // someObjects.sort((a, b) => a.someProperty.compareTo(b.someProperty));
    int indexListKeys = 0;
    // ORDENANDO LA LISTA DE PRODUCTOS
    listProducts
        .sort((a, b) => a.category.toString().compareTo(b.category.toString()));

    for (var element in listProducts) {
      if (!forValitation.contains(element.category)) {
        listGlobalKey.add(GlobalKey());
        listToReturn.add(_categorieProductText(indexListKeys, element));
        forValitation.add(element.category.toString());
        indexListKeys = indexListKeys + 1;
      }
      listToReturn.add(Material(
        child: InkWell(
          child: ItemProductList(product: element),
          onTap: () {
            navigateToPage(context, ProductScreen(product: element));
          },
        ),
      ));
    }
    return listToReturn;
  }

  Card _categorieProductText(int indexListKeys, ProductModel element) {
    return Card(
      key: listGlobalKey[indexListKeys],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              // Image.asset(
              //   getImageCategory(element.category.toString()),
              //   width: 30,
              //   height: 30,
              //   color: Colors.red[900],
              // ),
              // const SizedBox(width: 10),
              Expanded(
                child: Text(
                  element.category.toString(),
                  style: TextStyle(
                    color: Colors.red[900],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 2,
            color: Colors.red[900],
          )
        ],
      ),
    );
  }

  String getImageCategory(String item) {
    item = item.toLowerCase().trim();
    if (item == 'bebidas y postres') {
      return 'assets/images/iconoscategorias/postres.png';
    }
    if (item == 'broaster') {
      return 'assets/images/iconoscategorias/broaster.png';
    }
    if (item == 'hamburguesa') {
      return 'assets/images/iconoscategorias/burguer.png';
    }
    if (item == 'porciones') {
      return 'assets/images/iconoscategorias/porciones.png';
    }
    if (item == 'spiedo') {
      return 'assets/images/iconoscategorias/spiedo.png';
    }
    return 'assets/images/iconoscategorias/broaster.png';
  }

  InkWell _btnConfirmarPedido(Size size, ShopBloc shopBloc) {
    return InkWell(
      onTap: () {
        navigateToPage(context, const ShopDetailsScreen());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.red[900],
        ),
        width: size.width,
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Text(
              'Confirmar Pedido',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
            Text(
              '(${shopBloc.state.listProductShop.length}) items',
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
