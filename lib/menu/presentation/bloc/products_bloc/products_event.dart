part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}

class ProductsInitialEvent extends ProductsEvent {
  ProductsInitialEvent();
}

class ProductsLoadEvent extends ProductsEvent {
  ProductsLoadEvent();
}

class ProductsFinalEvent extends ProductsEvent {
  final List<ProductModel> listProducts;
  ProductsFinalEvent(this.listProducts);
}
