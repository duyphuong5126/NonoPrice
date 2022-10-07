import 'package:equatable/equatable.dart';
import 'product_category_uimodel.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeTitle extends HomeState {
  final String title;

  const HomeTitle({required this.title}) : super();

  @override
  List<Object?> get props => [title];
}

class HomeLoadingCategories extends HomeState {
  const HomeLoadingCategories() : super();

  @override
  List<Object?> get props => [1];
}

class HomeProductCategories extends HomeState {
  final String header;
  final Iterable<ProductCategoryUiModel> categories;

  const HomeProductCategories({required this.header, required this.categories});

  @override
  List<Object?> get props => [header, ...categories];
}

class HomeLoadingCategoriesFailure extends HomeState {
  final String message;

  const HomeLoadingCategoriesFailure({required this.message}) : super();

  @override
  List<Object?> get props => [message];
}
