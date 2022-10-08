import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../domain/usecase/get_product_list_use_case.dart';
import 'model/product_list_state.dart';
import 'model/product_overview_item.dart';

const int _compactFormatThreshold = 10000;

class ProductListCubit extends Cubit<ProductListState> {
  final GetProductListUseCase _getProductListUseCase;
  final NumberFormat _compactNumberFormat;
  final NumberFormat _defaultNumberFormat;

  ProductListCubit(
      {required GetProductListUseCase getProductListUseCase, Locale? locale})
      : _getProductListUseCase = getProductListUseCase,
        _compactNumberFormat =
            NumberFormat.compact(locale: locale?.languageCode),
        _defaultNumberFormat = NumberFormat('###,###', locale?.languageCode),
        super(
            const ProductOverviewList(pageTitle: 'Products', overviewList: []));

  void getProductList(String categoryId) async {
    emit(const LoadingProductList(message: 'Loading...'));
    (await _getProductListUseCase.execute(categoryId)).doOnSuccess(
      (productList) {
        int productCount = productList.length;
        String title = productCount == 0
            ? 'No product'
            : productCount == 1
                ? 'One product'
                : productCount >= _compactFormatThreshold
                    ? '${_compactNumberFormat.format(productCount)} products'
                    : '${_defaultNumberFormat.format(productCount)} products';
        emit(ProductOverviewList(
            pageTitle: title,
            overviewList: productList.map((product) => ProductOverView(
                productId: product.id,
                productName: product.name,
                thumbnailUrl: product.thumbnailUrl))));
      },
    ).doOnFailure((error) {
      emit(const LoadingProductListFailure(
        title: 'Could not load product list',
        message: 'Unknown error',
      ));
    });
  }
}
