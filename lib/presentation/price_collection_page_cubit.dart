import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nonoprice/domain/entity/product_price.dart';
import 'package:nonoprice/utility/collection_extension.dart';
import 'package:nonoprice/utility/scope_extension.dart';

import '../domain/entity/product.dart';
import '../domain/usecase/get_product_price_list_use_case.dart';
import 'model/price_collection_state.dart';
import 'model/price_uimodel.dart';

class PriceCollectionPageCubit extends Cubit<PriceCollectionState> {
  final GetProductPriceListUseCase _getProductPriceListUseCase;
  final NumberFormat _numberFormat;
  final NumberFormat _compactMoneyFormat;
  final DateFormat _standardDateFormat;
  final DateFormat _displayDateFormat;

  final String countryCode = 'vn';

  PriceCollectionPageCubit({
    required GetProductPriceListUseCase getProductPriceListUseCase,
    required NumberFormat numberFormat,
    required NumberFormat compactMoneyFormat,
    required DateFormat displayDateFormat,
    required DateFormat standardDateFormat,
  })  : _getProductPriceListUseCase = getProductPriceListUseCase,
        _numberFormat = numberFormat,
        _compactMoneyFormat = compactMoneyFormat,
        _displayDateFormat = displayDateFormat,
        _standardDateFormat = standardDateFormat,
        super(const LoadingPriceList());

  void init({required Product product}) async {
    (await _getProductPriceListUseCase.execute(
      categoryCode: product.categoryCode,
      codeName: product.codeName,
      countryCode: countryCode,
    ))
        .doOnSuccess(
      (priceList) {
        if (priceList.isEmpty) {
          return;
        }
        ProductPrice maxPriceItem = priceList.reduce(
          (value, element) => element.price > value.price ? element : value,
        );
        ProductPrice minPriceItem = priceList.reduce(
          (value, element) => element.price < value.price ? element : value,
        );

        String maxPrice = maxPriceItem.price.round().transform(_formatPrice);
        String minPrice = minPriceItem.price.round().transform(_formatPrice);

        DateTime maxPriceUpdatedTime =
            _standardDateFormat.parse(maxPriceItem.updatedAt);
        DateTime minPriceUpdatedTime =
            _standardDateFormat.parse(minPriceItem.updatedAt);
        DateTime lastUpdate =
            minPriceUpdatedTime.compareTo(maxPriceUpdatedTime) >= 0
                ? minPriceUpdatedTime
                : maxPriceUpdatedTime;
        emit(
          ProductOverview(
            name: product.name,
            priceRange: '$minPrice - $maxPrice ${maxPriceItem.currency}',
            lowestPriceTitle: 'Lowest option',
            lowestPrice:
                '${_numberFormat.format(minPriceItem.price.toInt())} ${minPriceItem.currency}',
            lowestPriceInfo: 'Option: ${minPriceItem.options}',
            updatedAt: 'Last update: ${_displayDateFormat.format(lastUpdate)}',
          ),
        );

        priceList
            .groupBy(
          (price) => '${product.name} - ${price.options}',
        )
            .transform(
          (groups) {
            final Map<String, Iterable<PriceItemUiModel>> finalGroups = {};
            groups.forEach(
              (key, priceList) {
                priceList.sort((a, b) => a.price.compareTo(b.price));
                finalGroups[key] = priceList.map(
                  (price) => PriceItemUiModel(
                    price:
                        '${_numberFormat.format(price.price)} ${price.currency}',
                    groupName: price.sourceGroupName,
                    updatedAt: _displayDateFormat
                        .format(_standardDateFormat.parse(price.updatedAt)),
                  ),
                );
              },
            );
            return ProductPriceGroups(
              otherChoicesTitle: 'Other options',
              priceGroups: finalGroups,
            );
          },
        ).perform(
          (priceGroups) => emit(priceGroups),
        );
      },
    ).doOnFailure(
      (error) {
        emit(
          ProductOverview(
            name: product.name,
            priceRange: 'No information about price range',
            lowestPriceTitle: 'No information about the price',
            lowestPrice: 'No information about the price',
            lowestPriceInfo: 'No information about the price',
            updatedAt: 'Last update: Unknown',
          ),
        );
      },
    );
  }

  String _formatPrice(int price) {
    return _compactMoneyFormat.format(price);
  }
}
