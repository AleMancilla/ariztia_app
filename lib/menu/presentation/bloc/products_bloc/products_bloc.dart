import 'package:ariztia_app/menu/data/models/product_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(const ProductsInitialState()) {
    on<ProductsEvent>((event, emit) {});
    on<ProductsLoadEvent>((event, emit) {
      emit(const ProductsLoadState());
    });
    on<ProductsFinalEvent>((event, emit) {
      emit(ProductsFinalState(event.listProducts));
    });
  }
}
