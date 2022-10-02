import 'package:nonoprice/domain/product_repository.dart';

import '../common/result.dart';
import '../entity/product_category.dart';

abstract class GetCategoryListUseCase {
  Future<Result<Iterable<ProductCategory>>> execute();
}

class GetCategoryListUseCaseImpl implements GetCategoryListUseCase {
  final ProductRepository _repository;

  GetCategoryListUseCaseImpl({required ProductRepository repository})
      : _repository = repository;

  @override
  Future<Result<Iterable<ProductCategory>>> execute() =>
      _repository.getCategoryList();
}
