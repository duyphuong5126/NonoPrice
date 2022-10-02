import '../domain/entity/product_category.dart';

class ProductCategoryFactory {
  static ProductCategory fromJson(dynamic json) {
    return ProductCategory(
        id: json['category_code'],
        name: json['category_name'],
        productCount: json['product_count']);
  }
}
