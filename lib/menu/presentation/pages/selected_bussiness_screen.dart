import 'package:ariztia_app/core/utils.dart';
import 'package:ariztia_app/menu/data/models/business_model.dart';
import 'package:ariztia_app/menu/presentation/bloc/business_bloc/business_bloc.dart';
import 'package:ariztia_app/menu/presentation/bloc/business_bloc/business_utils.dart';
import 'package:ariztia_app/menu/presentation/pages/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedBusinessScreen extends StatefulWidget {
  const SelectedBusinessScreen({Key? key}) : super(key: key);

  @override
  State<SelectedBusinessScreen> createState() => _SelectedBusinessScreenState();
}

class _SelectedBusinessScreenState extends State<SelectedBusinessScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final BusinessBloc businessBloc =
          BlocProvider.of<BusinessBloc>(context, listen: false);
      if (businessBloc.state.idBusiness != null &&
          businessBloc.state.idBusiness != 'null') {
        navigateToPage(context, MenuScreen());
        return;
      }
      chargeAllBusiness(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BusinessBloc businessBloc =
        BlocProvider.of<BusinessBloc>(context, listen: true);
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: businessBloc.state.listBusiness
              .map((BusinessModel businessModel) =>
                  _itemBusinessSelect(businessModel, businessBloc))
              .toList(),
        ),
      ),
    );
  }

  Widget _itemBusinessSelect(
      BusinessModel businessModel, BusinessBloc businessBloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.black12,
              offset: Offset(3, 3),
            )
          ],
        ),
        width: 130,
        height: 140,
        child: Material(
          child: InkWell(
            onTap: () {
              print(businessModel.name);
              businessBloc.add(
                  BusinessSelectOneEvent(businessModel.id, businessModel.name));
              navigateToPageAndRemove(context, MenuScreen());
            },
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.store,
                      size: 60,
                      color: Colors.red[900],
                    ),
                    Text('${businessModel.name}'),
                    // Text('Id'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
