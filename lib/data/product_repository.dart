import 'package:nonoprice/data/remote/product_remote_data_source.dart';
import 'package:nonoprice/domain/common/result.dart';

import 'package:nonoprice/domain/entity/product_category.dart';

import '../domain/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;

  ProductRepositoryImpl({required ProductRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<Result<Iterable<ProductCategory>>> getCategoryList() =>
      _remoteDataSource.getCategoryList();
}
