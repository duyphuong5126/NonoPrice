import '../common/result.dart';
import '../entity/product_price.dart';
import '../product_repository.dart';

abstract class GetProductPriceListUseCase {
  Future<Result<Iterable<ProductPrice>>> execute({
    required String categoryCode,
    required String codeName,
    required String countryCode,
  });
}

class GetProductPriceListUseCaseImpl implements GetProductPriceListUseCase {
  final ProductRepository _repository;

  GetProductPriceListUseCaseImpl({
    required ProductRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<Iterable<ProductPrice>>> execute({
    required String categoryCode,
    required String codeName,
    required String countryCode,
  }) =>
      _repository.getProductPriceList(
        categoryCode: categoryCode,
        codeName: codeName,
        countryCode: countryCode,
      );
}
