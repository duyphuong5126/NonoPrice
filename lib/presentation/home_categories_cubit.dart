import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nonoprice/domain/entity/product_category.dart';
import 'package:nonoprice/presentation/model/product_category_uimodel.dart';

import 'model/home_state.dart';

class HomeCategoryListCubit extends Cubit<HomeCategoryListState> {
  HomeCategoryListCubit() : super(const HomeLoadingCategories());

  void init() async {
    emit(HomeProductCategories(
        header: 'Choose a product type',
        categories: ProductCategory.values.map((type) => ProductCategoryUiModel(
            category: type,
            name: _productTypeName(type),
            countText: _productCounts(type)))));
  }

  String _productTypeName(ProductCategory productType) {
    switch (productType) {
      case ProductCategory.smartPhone:
        return 'Smartphone';
      case ProductCategory.tablet:
        return 'Tablet';
      case ProductCategory.laptop:
        return 'Laptop';
      case ProductCategory.mobileAccessory:
        return 'Mobile Accessory';
      case ProductCategory.smartTv:
        return 'Smart TV';
    }
  }

  String _productCounts(ProductCategory productType) {
    switch (productType) {
      case ProductCategory.smartPhone:
        return '(1,000,000 products)';
      case ProductCategory.tablet:
        return '(2,000,000 products)';
      case ProductCategory.laptop:
        return '(10,000,000 products)';
      case ProductCategory.mobileAccessory:
        return '(100,000,000 products)';
      case ProductCategory.smartTv:
        return '(5,000,000 products)';
    }
  }
}
