part of 'shop_bloc.dart';

@immutable
abstract class ShopState {
  final List<ProductShop> listProductShop;
  const ShopState(this.listProductShop);
}

class ShopInitial extends ShopState {
  ShopInitial() : super([]);
}

class ShopNewState extends ShopState {
  final List<ProductShop> listShop;
  const ShopNewState(this.listShop) : super(listShop);
}

class ProductShop {
  int amount;
  final ProductModel product;
  ProductShop(this.amount, this.product);

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'product': product.toJson(),
    };
  }
}
