import '../common/result.dart';
import '../entity/product.dart';
import '../product_repository.dart';

abstract class GetProductListUseCase {
  Future<Result<Iterable<Product>>> execute(String categoryId);
}

class GetProductListUseCaseImpl implements GetProductListUseCase {
  final ProductRepository _repository;

  GetProductListUseCaseImpl({required ProductRepository repository})
      : _repository = repository;

  @override
  Future<Result<Iterable<Product>>> execute(String categoryId) =>
      _repository.getProductList(categoryId);
}
