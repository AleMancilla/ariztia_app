import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitState()) {
    on<CategoryInitialEvent>((event, emit) {
      emit(CategorySelectState(event.categorie));
    });
    on<CategoryChangeEvent>((event, emit) {
      emit(CategorySelectState(event.categorie));
    });
  }
}
