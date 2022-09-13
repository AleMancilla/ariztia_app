import 'package:ariztia_app/menu/data/datasource/get_products_firestore_datasource.dart';
import 'package:ariztia_app/menu/data/models/product_model.dart';
import 'package:ariztia_app/menu/domain/repositories/read_products_firestore_repository.dart';

class ReadProductsFirestoreRepositoryImplements
    implements ReadProductsFirestoreRepository {
  final GetProductsFirestoreDatasource readProductsFirestoreDatasource =
      GetProductsFirestoreDatasource();

  // final String idBusiness;
  // ReadProductsFirestoreRepositoryImplements(this.idBusiness);

  @override
  Future<List<ProductModel>> readListProducts(String idBusiness) {
    try {
      return readProductsFirestoreDatasource.readProducts(idBusiness);
    } catch (e) {
      throw '$e';
    }
  }
}
