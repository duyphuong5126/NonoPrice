import 'package:intl/intl.dart';
import 'package:nonoprice/data/remote/product_remote_data_source.dart';
import 'package:get/get.dart';
import 'package:nonoprice/domain/product_repository.dart';
import 'package:nonoprice/domain/usecase/get_category_list_use_case.dart';
import 'package:nonoprice/domain/usecase/get_product_list_use_case.dart';
import 'package:nonoprice/domain/usecase/get_product_price_list_use_case.dart';
import 'package:nonoprice/presentation/home_cubit.dart';
import 'package:nonoprice/presentation/product_list_cubit.dart';

import '../data/product_repository.dart';
import '../presentation/price_collection_page_cubit.dart';
import '../shared/constant.dart';

class DependencyManager {
  static void init() {
    Get.put<ProductRemoteDataSource>(
      ProductRemoteDataSourceImpl(),
      permanent: true,
    );

    Get.put<ProductRepository>(
      ProductRepositoryImpl(
        remoteDataSource: Get.find(),
      ),
      permanent: true,
    );

    Get.put<GetCategoryListUseCase>(
      GetCategoryListUseCaseImpl(
        repository: Get.find(),
      ),
    );

    Get.put<GetProductListUseCase>(
      GetProductListUseCaseImpl(
        repository: Get.find(),
      ),
    );

    Get.put<GetProductPriceListUseCase>(
      GetProductPriceListUseCaseImpl(
        repository: Get.find(),
      ),
    );

    Get.create<NumberFormat>(
      () => NumberFormat(
        '#,###.###',
        Intl.getCurrentLocale(),
      ),
      tag: defaultNumberFormatter,
    );

    Get.create<NumberFormat>(
      () => NumberFormat.compact(
        locale: Intl.getCurrentLocale(),
      ),
      tag: compactMoneyFormatter,
    );

    Get.create<DateFormat>(
      () => DateFormat(
        "yyyy-MM-dd'T'HH:mm:ss.SSS zzz",
        Intl.getCurrentLocale(),
      ),
      tag: standardDateTimeFormatter,
    );

    Get.create<DateFormat>(
      () => DateFormat(
        'EEE, d MMM yyyy, HH:mm',
        Intl.getCurrentLocale(),
      ),
      tag: displayCompactDateTimeFormatter,
    );

    Get.create(
      () => HomeCubit(
        getCategoriesUseCase: Get.find(),
        locale: Get.deviceLocale,
      ),
      permanent: false,
    );

    Get.create(
      () => ProductListCubit(
        getProductListUseCase: Get.find(),
        locale: Get.deviceLocale,
      ),
      permanent: false,
    );

    Get.create(
      () => PriceCollectionPageCubit(
        getProductPriceListUseCase: Get.find(),
        numberFormat: getByTag(tag: defaultNumberFormatter),
        compactMoneyFormat: getByTag(tag: compactMoneyFormatter),
        displayDateFormat: getByTag(tag: displayCompactDateTimeFormatter),
        standardDateFormat: getByTag(tag: standardDateTimeFormatter),
      ),
      permanent: false,
    );
  }

  static T get<T>() {
    return Get.find();
  }

  static T getByTag<T>({
    required String tag,
  }) {
    return Get.find(tag: tag);
  }
}
