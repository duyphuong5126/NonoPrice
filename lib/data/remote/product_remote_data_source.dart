import 'dart:convert';

import 'package:http/http.dart';

import '../../domain/common/result.dart';
import '../../domain/entity/product.dart';
import '../../domain/entity/product_category.dart';
import '../../domain/entity/product_price.dart';
import '../../utility/log.dart';
import '../product_category_factory.dart';
import '../product_price_factory.dart';

const _baseurl =
    'https://raw.githubusercontent.com/duyphuong5126/TechProductsDB';
const _productCategoryApi = '$_baseurl/main/v1/product_categories.json';
const _productListApiTemplate = '$_baseurl/main/v1/{product_category}.json';
const _productPriceListApiTemplate =
    '$_baseurl/main/v1/{country_code}/price/{product_category}/{product_category}_{code_name}.json';

abstract class ProductRemoteDataSource {
  Future<Result<Iterable<ProductCategory>>> getCategoryList();

  Future<Result<Iterable<Product>>> getProductList(
      {required String categoryId});

  Future<Result<Iterable<ProductPrice>>> getProductPriceList({
    required String categoryCode,
    required String codeName,
    required String countryCode,
  });
}

class ProductRemoteDataSourceImpl
    with LogMixin
    implements ProductRemoteDataSource {
  @override
  Future<Result<Iterable<ProductCategory>>> getCategoryList() async {
    try {
      Response response = await get(Uri.parse(_productCategoryApi));
      Iterable<dynamic> responseItems = jsonDecode(response.body);
      logDebug(
          '\n-------------------\nGET $_productCategoryApi\nResult: ${response.statusCode} - data=$responseItems\n-------------------');
      return Future.value(
        Success(
          data: responseItems.map(
            (json) => ProductCategoryFactory.fromJson(json),
          ),
        ),
      );
    } on Exception catch (e) {
      logError(
          '\n-------------------\nGET $_productCategoryApi\nError: $e\n-------------------');
      return Failure(error: e);
    }
  }

  @override
  Future<Result<Iterable<Product>>> getProductList(
      {required String categoryId}) async {
    String url = _getProductListUrl(categoryId: categoryId);
    try {
      Response response = await get(Uri.parse(url));
      Iterable<dynamic> responseItems = jsonDecode(response.body);
      logDebug(
          '\n-------------------\nGET $url\nResult: ${response.statusCode} - data=$responseItems\n-------------------');
      return Future.value(
        Success(
          data: responseItems.map(
            (json) {
              String imageBaseUrl = json['image_base_url'];
              return Product(
                codeName: json['code_name'],
                name: json['name'],
                categoryCode: json['category_code'],
                photoUrl: '$imageBaseUrl${json['photo_path']}',
                thumbnailUrl: '$imageBaseUrl${json['thumbnail_path']}',
              );
            },
          ),
        ),
      );
    } on Exception catch (e) {
      logError(
          '\n-------------------\nGET $url\nError: $e\n-------------------');
      return Failure(error: e);
    }
  }

  @override
  Future<Result<Iterable<ProductPrice>>> getProductPriceList({
    required String categoryCode,
    required String codeName,
    required String countryCode,
  }) async {
    String url = _getProductPriceListUrl(
      categoryCode: categoryCode,
      codeName: codeName,
      countryCode: countryCode,
    );
    try {
      Response response = await get(Uri.parse(url));
      Iterable<dynamic> responseItems = jsonDecode(response.body);
      logDebug(
          '\n-------------------\nGET $url\nResult: ${response.statusCode} - data=$responseItems\n-------------------');
      return Future.value(
        Success(
          data: responseItems.map(
            (json) => ProductPriceFactory.fromJson(json),
          ),
        ),
      );
    } on Exception catch (e) {
      logError(
          '\n-------------------\nGET $_productCategoryApi\nError: $e\n-------------------');
      return Failure(error: e);
    }
  }

  String _getProductListUrl({required String categoryId}) {
    return _productListApiTemplate.replaceFirst(
        '{product_category}', categoryId);
  }

  String _getProductPriceListUrl({
    required String categoryCode,
    required String codeName,
    required String countryCode,
  }) {
    return _productPriceListApiTemplate
        .replaceAll('{country_code}', countryCode)
        .replaceAll('{product_category}', categoryCode)
        .replaceAll('{code_name}', codeName);
  }
}
