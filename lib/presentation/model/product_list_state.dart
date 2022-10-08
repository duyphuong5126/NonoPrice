import 'package:equatable/equatable.dart';

import 'product_overview_item.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();
}

class LoadingProductList extends ProductListState {
  final String message;

  const LoadingProductList({required this.message});

  @override
  List<Object?> get props => [message];
}

class LoadingProductListFailure extends ProductListState {
  final String title;
  final String message;

  const LoadingProductListFailure({required this.title, required this.message});

  @override
  List<Object?> get props => [title, message];
}

class ProductOverviewList extends ProductListState {
  final String pageTitle;
  final Iterable<ProductOverView> overviewList;

  const ProductOverviewList(
      {required this.pageTitle, required this.overviewList});

  @override
  List<Object?> get props =>
      [pageTitle, ...overviewList.map((e) => e.productId)];
}
