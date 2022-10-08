import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nonoprice/shared/widget/loading_error_page_android.dart';
import 'package:nonoprice/shared/widget/loading_page_android.dart';
import 'package:nonoprice/utility/image_extension.dart';
import 'package:nonoprice/utility/material_context_extension.dart';

import '../../shared/constant.dart';
import '../model/product_list_state.dart';
import '../model/product_overview_item.dart';
import '../product_list_cubit.dart';

class ProductListAndroid extends StatefulWidget {
  const ProductListAndroid({Key? key}) : super(key: key);

  @override
  State<ProductListAndroid> createState() => _ProductListAndroidState();
}

class _ProductListAndroidState extends State<ProductListAndroid> {
  @override
  Widget build(BuildContext context) {
    String categoryId = ModalRoute.of(context)?.settings.arguments as String;
    context.read<ProductListCubit>().init(categoryId);
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ProductListCubit, ProductListState>(
            buildWhen: (prev, current) {
          return current is ProductOverviewList;
        }, builder: (context, state) {
          String title =
              state is ProductOverviewList ? state.pageTitle : 'Products';
          return Text(
            title,
            style: TextStyle(inherit: true, color: context.primaryColor),
          );
        }),
      ),
      body: const _ProductListArea(),
    );
  }
}

class _ProductListArea extends StatefulWidget {
  const _ProductListArea({Key? key}) : super(key: key);

  @override
  State<_ProductListArea> createState() => _ProductListAreaState();
}

class _ProductListAreaState extends State<_ProductListArea> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListCubit, ProductListState>(
        builder: (context, state) {
      return state is ProductOverviewList
          ? _ProductList(
              productList: state.overviewList,
            )
          : state is LoadingProductList
              ? LoadingPageAndroid(
                  message: state.message,
                )
              : state is LoadingProductListFailure
                  ? LoadingErrorPageAndroid(
                      errorTitle: state.title,
                      errorMessage: state.message,
                    )
                  : throw Exception('Illegal state $state');
    });
  }
}

class _ProductList extends StatelessWidget {
  final Iterable<ProductOverView> productList;

  const _ProductList({
    Key? key,
    required this.productList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(bottom: defaultListThumbnailSize),
        itemCount: productList.length,
        itemBuilder: (context, index) {
          ProductOverView productOverView = productList.elementAt(index);
          return Container(
            padding: const EdgeInsets.symmetric(
                vertical: mediumSpace, horizontal: normalSpace),
            child: Row(
              children: [
                Image(
                  width: defaultListThumbnailSize,
                  height: defaultListThumbnailSize,
                  image: NetworkImage(productOverView.thumbnailUrl),
                  loadingBuilder: (context, child, loadingProgress) {
                    return loadingProgress?.isLoadingFinished == true
                        ? const SizedBox(
                            width: 8,
                            height: 8,
                            child: CircularProgressIndicator(),
                          )
                        : child;
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.white,
                      width: defaultListThumbnailSize,
                      height: defaultListThumbnailSize,
                    );
                  },
                ),
                const SizedBox(
                  width: normalSpace,
                ),
                Text(
                  productOverView.productName,
                  style: context.bodyLarge,
                )
              ],
            ),
          );
        });
  }
}
