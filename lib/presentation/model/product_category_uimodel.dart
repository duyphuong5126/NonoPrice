import 'package:equatable/equatable.dart';
import 'package:nonoprice/domain/entity/product_category.dart';

class ProductCategoryUiModel extends Equatable {
  final ProductCategory category;
  final String name;
  final String countText;

  const ProductCategoryUiModel(
      {required this.category, required this.name, required this.countText})
      : super();

  @override
  List<Object?> get props => [category, name];
}
