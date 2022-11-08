import 'package:nonoprice/data/remote/product_remote_data_source.dart';
import 'package:nonoprice/domain/common/result.dart';
import 'package:nonoprice/domain/entity/product.dart';

import 'package:nonoprice/domain/entity/product_category.dart';
import 'package:nonoprice/domain/entity/product_price.dart';

import '../domain/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;

  ProductRepositoryImpl({
    required ProductRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Result<Iterable<ProductCategory>>> getCategoryList() =>
      _remoteDataSource.getCategoryList();

  @override
  Future<Result<Iterable<Product>>> getProductList(String categoryId) =>
      _remoteDataSource.getProductList(categoryId: categoryId);

  @override
  Future<Result<Iterable<ProductPrice>>> getProductPriceList({
    required String categoryCode,
    required String codeName,
    required String countryCode,
  }) =>
      _remoteDataSource.getProductPriceList(
        categoryCode: categoryCode,
        codeName: codeName,
        countryCode: countryCode,
      );
}
