part of 'business_bloc.dart';

@immutable
abstract class BusinessState {
  String idBusiness;
  String nameBusiness;
  List<BusinessModel> listBusiness;
  // BusinessState();
  BusinessState(this.idBusiness, this.nameBusiness, this.listBusiness);
}

class BusinessInitial extends BusinessState {
  BusinessInitial() : super('null', 'null', []);
}

class BusinessSelectedState extends BusinessState {
  final String id;
  final String name;
  List<BusinessModel> list;
  BusinessSelectedState(this.id, this.name, this.list) : super(id, name, list);
}

class BusinessListState extends BusinessState {
  List<BusinessModel> listBusiness;
  BusinessListState(this.listBusiness) : super('', '', listBusiness);
}
