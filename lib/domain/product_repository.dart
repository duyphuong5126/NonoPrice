import 'common/result.dart';
import 'entity/product.dart';
import 'entity/product_category.dart';
import 'entity/product_price.dart';

abstract class ProductRepository {
  Future<Result<Iterable<ProductCategory>>> getCategoryList();

  Future<Result<Iterable<Product>>> getProductList(String categoryId);

  Future<Result<Iterable<ProductPrice>>> getProductPriceList({
    required String categoryCode,
    required String codeName,
    required String countryCode,
  });
}
