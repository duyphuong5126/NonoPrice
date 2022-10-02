import 'package:equatable/equatable.dart';

class ProductCategoryUiModel extends Equatable {
  final String categoryId;
  final String name;
  final String countText;

  const ProductCategoryUiModel(
      {required this.categoryId, required this.name, required this.countText})
      : super();

  @override
  List<Object?> get props => [categoryId, name, countText];
}
