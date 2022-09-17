import 'package:ariztia_app/menu/data/models/business_model.dart';

abstract class ReadBusinessFirestoreRepository {
  Future<List<BusinessModel>> readListBusiness();
}
