import 'package:ariztia_app/menu/data/models/product_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(ShopInitial()) {
    on<ShopEvent>((event, emit) {});
    on<ShopAddProductEvent>((event, emit) {
      emit(ShopNewState(event.listShop));
    });
  }
}
