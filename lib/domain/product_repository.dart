import 'common/result.dart';
import 'entity/product_category.dart';

abstract class ProductRepository {
  Future<Result<Iterable<ProductCategory>>> getCategoryList();
}
