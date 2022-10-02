part of 'shop_bloc.dart';

@immutable
abstract class ShopEvent {}

class ShopAddProductEvent extends ShopEvent {
  final List<ProductShop> listShop;

  ShopAddProductEvent(this.listShop);
}

class ShopRemoveOneProductEvent extends ShopEvent {
  final ProductShop itemShop;

  ShopRemoveOneProductEvent(this.itemShop);
}

class ShopRemoveProductEvent extends ShopEvent {
  ShopRemoveProductEvent();
}
