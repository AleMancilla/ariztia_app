part of 'category_bloc.dart';

@immutable
abstract class CategoryState {
  final String categorie;
  const CategoryState(this.categorie);
}

class CategoryInitState extends CategoryState {
  const CategoryInitState() : super('No Information');
}

class CategorySelectState extends CategoryState {
  const CategorySelectState(String categorie) : super(categorie);
}
