import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nonoprice/presentation/model/product_category_uimodel.dart';

import '../domain/usecase/get_category_list_use_case.dart';
import 'model/home_state.dart';

const int _compactFormatThreshold = 1000000;

class HomeCategoryListCubit extends Cubit<HomeCategoryListState> {
  final GetCategoryListUseCase _getCategoriesUseCase;
  final NumberFormat _compactNumberFormat;
  final NumberFormat _defaultNumberFormat;

  HomeCategoryListCubit(
      {required GetCategoryListUseCase getCategoriesUseCase, Locale? locale})
      : _getCategoriesUseCase = getCategoriesUseCase,
        _compactNumberFormat =
            NumberFormat.compact(locale: locale?.languageCode),
        _defaultNumberFormat = NumberFormat('###,###', locale?.languageCode),
        super(const HomeLoadingCategories());

  void getCategoryList() async {
    emit(const HomeLoadingCategories());
    (await _getCategoriesUseCase.execute()).doOnSuccess((categories) {
      emit(HomeProductCategories(
          header: 'Choose a product type',
          categories: categories.map((category) {
            String formattedCount =
                category.productCount >= _compactFormatThreshold
                    ? '(${_compactNumberFormat.format(category.productCount)})'
                    : '(${_defaultNumberFormat.format(category.productCount)})';
            return ProductCategoryUiModel(
                categoryId: category.id,
                name: category.name,
                countText: formattedCount);
          })));
    }).doOnFailure((error) {
      emit(const HomeLoadingCategoriesFailure(
          message: 'Could not load category list'));
    });
  }
}
