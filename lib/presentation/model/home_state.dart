import 'package:equatable/equatable.dart';
import 'product_category_uimodel.dart';

abstract class HomeCategoryListState extends Equatable {
  const HomeCategoryListState();
}

class HomeLoadingCategories extends HomeCategoryListState {
  const HomeLoadingCategories() : super();

  @override
  List<Object?> get props => [1];
}

class HomeProductCategories extends HomeCategoryListState {
  final String header;
  final Iterable<ProductCategoryUiModel> categories;

  const HomeProductCategories({required this.header, required this.categories});

  @override
  List<Object?> get props => [header, ...categories];
}

class HomeLoadingCategoriesFailure extends HomeCategoryListState {
  final String message;

  const HomeLoadingCategoriesFailure({required this.message}) : super();

  @override
  List<Object?> get props => [message];
}
