import 'common/result.dart';
import 'entity/product.dart';
import 'entity/product_category.dart';

abstract class ProductRepository {
  Future<Result<Iterable<ProductCategory>>> getCategoryList();

  Future<Result<Iterable<Product>>> getProductList(String categoryId);
}
