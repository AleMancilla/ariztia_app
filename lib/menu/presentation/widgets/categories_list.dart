import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList(
      {Key? key,
      this.categories = const [
        'opcion 1',
        'opcion 2',
        'opcion 3',
        'opcion 4',
        'opcion 5',
        'opcion 6',
        'opcion 7',
        'opcion 8'
      ]})
      : super(key: key);
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((e) => _btnCategorie(e)).toList(),
      ),
    );
  }

  InkWell _btnCategorie(String e) => InkWell(
        onTap: () {
          print(e);
        },
        child: CategorieItem(title: e),
      );
}

class CategorieItem extends StatelessWidget {
  const CategorieItem({Key? key, required this.title, this.isSelect = true})
      : super(key: key);
  final String title;
  final bool isSelect;

  @override
  Widget build(BuildContext context) {
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
