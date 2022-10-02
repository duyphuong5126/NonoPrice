import 'dart:convert';

import 'package:http/http.dart';
import 'package:nonoprice/data/product_category_factory.dart';
import 'package:nonoprice/domain/entity/product_category.dart';

import '../../domain/common/result.dart';
import '../../utility/log.dart';

const _baseurl =
    'https://raw.githubusercontent.com/duyphuong5126/TechProductsDB';
const _productCategoryApi = '$_baseurl/main/v1/product_categories.json';

abstract class ProductRemoteDataSource {
  Future<Result<Iterable<ProductCategory>>> getCategoryList();
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
}
