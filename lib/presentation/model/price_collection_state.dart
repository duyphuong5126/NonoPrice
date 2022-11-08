import 'package:equatable/equatable.dart';
import 'package:nonoprice/presentation/model/price_uimodel.dart';

abstract class PriceCollectionState extends Equatable {
  const PriceCollectionState();
}

class LoadingPriceList extends PriceCollectionState {
  const LoadingPriceList();

  @override
  List<Object?> get props => [1];
}

class ProductOverview extends PriceCollectionState {
  final String name;
  final String priceRange;
  final String lowestPriceTitle;
  final String lowestPrice;
  final String lowestPriceInfo;
  final String updatedAt;

  const ProductOverview({
    required this.name,
    required this.priceRange,
    required this.lowestPriceTitle,
    required this.lowestPrice,
    required this.lowestPriceInfo,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        name,
        priceRange,
        updatedAt,
      ];
}

class ProductPriceGroups extends PriceCollectionState {
  final String otherChoicesTitle;
  final Map<String, Iterable<PriceItemUiModel>> priceGroups;

  const ProductPriceGroups({
    required this.otherChoicesTitle,
    required this.priceGroups,
  });

  @override
  List<Object?> get props => [
        ...priceGroups.keys,
        ...priceGroups.values,
      ];
}

class PriceListEmpty extends PriceCollectionState {
  final String message;

  const PriceListEmpty({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
