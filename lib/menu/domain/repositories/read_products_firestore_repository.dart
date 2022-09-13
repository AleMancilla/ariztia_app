import 'package:ariztia_app/menu/data/models/product_model.dart';

abstract class ReadProductsFirestoreRepository {
  Future<List<ProductModel>> readListProducts(String idBusiness);
}
