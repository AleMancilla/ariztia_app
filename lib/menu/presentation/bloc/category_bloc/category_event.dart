part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class CategoryInitialEvent extends CategoryEvent {
  final String categorie;
  CategoryInitialEvent(this.categorie);
}

class CategoryChangeEvent extends CategoryEvent {
  final String categorie;
  CategoryChangeEvent(this.categorie);
}
