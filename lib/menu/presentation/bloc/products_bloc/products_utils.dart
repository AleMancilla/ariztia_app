import 'package:ariztia_app/core/utils.dart';
import 'package:ariztia_app/menu/data/models/product_model.dart';
import 'package:ariztia_app/menu/data/repositories/read_products_firestore_repository_implement.dart';
import 'package:ariztia_app/menu/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:ariztia_app/menu/presentation/bloc/products_bloc/products_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final ReadProductsFirestoreRepositoryImplements
    readProductsFirestoreRepositoryImplements =
    ReadProductsFirestoreRepositoryImplements();

Future<void> chargeAllProducts(BuildContext context,
    {ProductsBloc? productsBloc,
    String idBusinnes = 'OU0xmGobwJr7GrjJYAAr'}) async {
  productsBloc ??= BlocProvider.of<ProductsBloc>(context, listen: false);
  await Future.delayed(Duration.zero, () async {
    // showProgressIndicator(context);
    await loadingAsyncFunction(context, () async {
      return await getAllProducts(productsBloc!, idBusinnes, context);
    });
  });
}

Future getAllProducts(
    ProductsBloc _productsBloc, String idBusinnes, BuildContext context) async {
  await readProductsFirestoreRepositoryImplements
      .readListProducts(idBusinnes)
      .then((value) {
    _productsBloc.add(ProductsFinalEvent(value));

    final CategoryBloc categoryBloc =
        BlocProvider.of<CategoryBloc>(context, listen: false);
    categoryBloc
        .add(CategoriesListChargeEvent(chargeAllCategories(context, value)));
    // print(categoryBloc);
  }).onError((error, stackTrace) {
    return throw '$error';
  });
}

List<String> chargeAllCategories(
    BuildContext context, List<ProductModel> listProducts) {
  List<String> listCategories = [];
  print(listProducts);
  listProducts.forEach((element) {
    if (!listCategories.contains(element.category)) {
      listCategories.add(element.category.toString());
    }
  });
  return listCategories;
}
