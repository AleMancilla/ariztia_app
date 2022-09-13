import 'package:ariztia_app/menu/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesList extends StatefulWidget {
  final CategoryBloc categoryBloc;
  const CategoriesList({
    Key? key,
    this.categories = const [
      'opcion 1',
      'opcion 2',
      'opcion 3',
      'opcion 4',
      'opcion 5',
      'opcion 6',
      'opcion 7',
      'opcion 8'
    ],
    required this.categoryBloc,
  }) : super(key: key);
  final List<String> categories;

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (widget.categories.isNotEmpty) {
        widget.categoryBloc.add(CategoryChangeEvent(widget.categories[0]));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (_, state) {
          print('===> category = ${state.categorie}');
          return Row(
            children: widget.categories
                .map((e) => _btnCategorie(e, context))
                .toList(),
          );
        },
      ),
    );
  }

  InkWell _btnCategorie(String e, BuildContext contextc) => InkWell(
        onTap: () {
          widget.categoryBloc.add(CategoryChangeEvent(e));
          print(e);
        },
        child: CategorieItem(title: e, categoryBloc: widget.categoryBloc),
      );
}

class CategorieItem extends StatelessWidget {
  const CategorieItem(
      {Key? key, required this.title, required this.categoryBloc})
      : super(key: key);
  final String title;
  final CategoryBloc categoryBloc;

  @override
  Widget build(BuildContext context) {
    bool isSelect = categoryBloc.state.categorie == title;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isSelect ? Colors.red.shade100 : Colors.transparent,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        title,
        style: TextStyle(
            color: isSelect ? Colors.red[900] : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
