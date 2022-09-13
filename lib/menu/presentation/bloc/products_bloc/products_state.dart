part of 'products_bloc.dart';

@immutable
abstract class ProductsState {
  const ProductsState(this.listProduct);
  final List<ProductModel> listProduct;
}

class ProductsInitialState extends ProductsState {
  const ProductsInitialState() : super(const []);
}

class ProductsLoadState extends ProductsState {
  const ProductsLoadState() : super(const []);
}

class ProductsFinalState extends ProductsState {
  final List<ProductModel> listProducts;
  const ProductsFinalState(this.listProducts) : super(listProducts);
}
