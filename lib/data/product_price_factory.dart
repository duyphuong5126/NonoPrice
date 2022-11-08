import '../domain/entity/product_price.dart';

class ProductPriceFactory {
  static ProductPrice fromJson(dynamic json) {
    return ProductPrice(
      codeName: json['code_name'],
      options: json['options'],
      categoryCode: json['category_code'],
      price: json['price'],
      currency: json['currency'],
      countryCode: json['country_code'],
      sourceGroupName: json['source_group_name'],
      sourceURL: json['source_url'],
      updatedAt: json['updated_at'],
    );
  }
}
