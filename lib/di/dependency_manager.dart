import 'package:nonoprice/data/remote/product_remote_data_source.dart';
import 'package:get/get.dart';
import 'package:nonoprice/domain/product_repository.dart';
import 'package:nonoprice/domain/usecase/get_category_list_use_case.dart';
import 'package:nonoprice/domain/usecase/get_product_list_use_case.dart';
import 'package:nonoprice/presentation/home_cubit.dart';

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

    Get.put<HomeCubit>(
      HomeCubit(getCategoriesUseCase: Get.find(), locale: Get.deviceLocale),
    );
  }

  static T get<T>() {
    return Get.find();
  }
}
