import 'package:ariztia_app/core/utils.dart';
import 'package:ariztia_app/menu/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:ariztia_app/menu/presentation/bloc/products_bloc/products_bloc.dart';
import 'package:ariztia_app/menu/presentation/bloc/products_bloc/products_utils.dart';
import 'package:ariztia_app/menu/presentation/pages/product_page.dart';
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
  @override
  void initState() {
    chargeAllProducts(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CategoryBloc categoryBloc =
        BlocProvider.of<CategoryBloc>(context, listen: false);
    // final ProductsBloc productsBloc =
    //     BlocProvider.of<ProductsBloc>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const AppBarAriztia(),
            const SizedBox(height: 10),
            CategoriesList(categoryBloc: categoryBloc),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoadState) {
                    return const Text('cargando....');
                  }
                  if (state is ProductsFinalState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: ListView(
                        children: state.listProduct
                            .map(
                              (e) => Material(
                                child: InkWell(
                                  child: ItemProductList(product: e),
                                  onTap: () {
                                    navigateToPage(
                                        context, ProductPage(product: e));
                                  },
                                ),
                              ),
                            )
                            .toList(),
                        scrollDirection: Axis.vertical,
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
