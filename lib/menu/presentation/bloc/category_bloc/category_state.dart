part of 'category_bloc.dart';

@immutable
abstract class CategoryState {
  final String categorie;
  final List<String> listCategories;
  const CategoryState(this.categorie, this.listCategories);
}

class CategoryInitState extends CategoryState {
  const CategoryInitState() : super('No Information', const []);
}

class CategoryListCategoriesState extends CategoryState {
  const CategoryListCategoriesState(List<String> list)
      : super('No Information', list);
}

class CategorySelectState extends CategoryState {
  const CategorySelectState(String categorie, List<String> list)
      : super(categorie, list);
}
