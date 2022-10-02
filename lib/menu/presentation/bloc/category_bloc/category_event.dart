part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class CategoryInitialEvent extends CategoryEvent {
  final String categorie;
  final List<String> lista;
  CategoryInitialEvent(this.categorie, this.lista);
}

class CategoryChangeEvent extends CategoryEvent {
  final String categorie;
  final List<String> lista;
  CategoryChangeEvent(this.categorie, this.lista);
}

class CategoriesListChargeEvent extends CategoryEvent {
  final List<String> lista;
  CategoriesListChargeEvent(this.lista);
}
