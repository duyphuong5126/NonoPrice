import 'dart:convert';

import 'package:http/http.dart';
import 'package:nonoprice/data/product_category_factory.dart';
import 'package:nonoprice/domain/entity/product_category.dart';

import '../../domain/common/result.dart';
import '../../domain/entity/product.dart';
import '../../utility/log.dart';

const _baseurl =
    'https://raw.githubusercontent.com/duyphuong5126/TechProductsDB';
const _productCategoryApi = '$_baseurl/main/v1/product_categories.json';
const _productListApiTemplate = '$_baseurl/main/v1/{product_category}.json';

abstract class ProductRemoteDataSource {
  Future<Result<Iterable<ProductCategory>>> getCategoryList();

  Future<Result<Iterable<Product>>> getProductList(String categoryId);
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
      return Future.value(Success(
          data: responseItems
              .map((json) => ProductCategoryFactory.fromJson(json))));
    } on Exception catch (e) {
      logError(
          '\n-------------------\nGET $_productCategoryApi\nError: $e\n-------------------');
      return Failure(error: e);
    }
  }

  @override
  Future<Result<Iterable<Product>>> getProductList(String categoryId) async {
    String url = _getProductListUrl(categoryId);
    try {
      Response response = await get(Uri.parse(url));
      Iterable<dynamic> responseItems = jsonDecode(response.body);
      logDebug(
          '\n-------------------\nGET $url\nResult: ${response.statusCode} - data=$responseItems\n-------------------');
      return Future.value(Success(data: responseItems.map((json) {
        String imageBaseUrl = json['image_base_url'];
        return Product(
          id: json['code_name'],
          name: json['name'],
          photoUrl: '$imageBaseUrl${json['photo_path']}',
          thumbnailUrl: '$imageBaseUrl${json['thumbnail_path']}',
        );
      })));
    } on Exception catch (e) {
      logError(
          '\n-------------------\nGET $url\nError: $e\n-------------------');
      return Failure(error: e);
    }
  }

  String _getProductListUrl(String categoryId) {
    return _productListApiTemplate.replaceFirst(
        '{product_category}', categoryId);
  }
}
