import 'package:ariztia_app/menu/data/datasource/get_products_firestore_datasource.dart';
import 'package:ariztia_app/menu/data/models/product_model.dart';
import 'package:ariztia_app/menu/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:ariztia_app/menu/presentation/widgets/app_bar_ariztia.dart';
import 'package:ariztia_app/menu/presentation/widgets/categories_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    final CategoryBloc categoryBloc =
        BlocProvider.of<CategoryBloc>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () async {
          // OU0xmGobwJr7GrjJYAAr - ARISTIA
          List<ProductModel> lista = await GetProductsFirestoreDatasource()
              .readArticles('OU0xmGobwJr7GrjJYAAr');
          print(lista);
        }),
        body: Column(
          children: [
            AppBarAriztia(),
            CategoriesList(categoryBloc: categoryBloc),
          ],
        ),
      ),
    );
  }
}
