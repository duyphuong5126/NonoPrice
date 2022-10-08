import 'package:nonoprice/data/remote/product_remote_data_source.dart';
import 'package:get/get.dart';
import 'package:nonoprice/domain/product_repository.dart';
import 'package:nonoprice/domain/usecase/get_category_list_use_case.dart';
import 'package:nonoprice/domain/usecase/get_product_list_use_case.dart';
import 'package:nonoprice/presentation/home_cubit.dart';
import 'package:nonoprice/presentation/product_list_cubit.dart';

import '../data/product_repository.dart';

class DependencyManager {
  static void init() {
    Get.put<ProductRemoteDataSource>(ProductRemoteDataSourceImpl(),
        permanent: true);

    Get.put<ProductRepository>(
        ProductRepositoryImpl(remoteDataSource: Get.find()),
        permanent: true);

    Get.put<GetCategoryListUseCase>(
      GetCategoryListUseCaseImpl(repository: Get.find()),
    );

    Get.put<GetProductListUseCase>(
      GetProductListUseCaseImpl(repository: Get.find()),
    );

    Get.create(
        () => HomeCubit(
            getCategoriesUseCase: Get.find(), locale: Get.deviceLocale),
        permanent: false);

    Get.create(
        () => ProductListCubit(
            getProductListUseCase: Get.find(), locale: Get.deviceLocale),
        permanent: false);
  }

  static T get<T>() {
    return Get.find();
  }
}
