import 'package:ariztia_app/menu/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesList extends StatefulWidget {
  final CategoryBloc categoryBloc;
  final Function(String) changeCategory;
  const CategoriesList({
    Key? key,
    this.categories = const [],
    required this.categoryBloc,
    required this.changeCategory,
  }) : super(key: key);
  final List<String> categories;

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 1500), () {
      widget.categories.sort(
        (a, b) => a.compareTo(b),
      );
      if (widget.categories.isNotEmpty) {
        widget.categoryBloc.add(CategoryChangeEvent(
            widget.categories[0], widget.categoryBloc.state.listCategories));
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
          widget.categoryBloc.add(
              CategoryChangeEvent(e, widget.categoryBloc.state.listCategories));
          widget.changeCategory(e);
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
      child: Row(
        children: [
          if (isSelect)
            Image.asset(
              getImageCategory(title.toString()),
              width: 30,
              height: 30,
              color: Colors.red[900],
            ),
          Text(
            title,
            style: TextStyle(
                color: isSelect ? Colors.red[900] : Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  String getImageCategory(String item) {
    item = item.toLowerCase().trim();
    if (item == 'bebidas y postres') {
      return 'assets/images/iconoscategorias/postres.png';
    }
    if (item == 'broaster') {
      return 'assets/images/iconoscategorias/broaster.png';
    }
    if (item == 'hamburguesa') {
      return 'assets/images/iconoscategorias/burguer.png';
    }
    if (item == 'porciones') {
      return 'assets/images/iconoscategorias/porciones.png';
    }
    if (item == 'spiedo') {
      return 'assets/images/iconoscategorias/spiedo.png';
    }
    return 'assets/images/iconoscategorias/broaster.png';
  }
}
