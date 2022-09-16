part of 'shop_bloc.dart';

@immutable
abstract class ShopEvent {}

class ShopAddProductEvent extends ShopEvent {
  final List<ProductShop> listShop;

  ShopAddProductEvent(this.listShop);
}
