import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nonoprice/presentation/model/product_list_state.dart';
import 'package:nonoprice/presentation/product_list_cubit.dart';
import 'package:nonoprice/shared/widget/loading_page_ios.dart';
import 'package:nonoprice/utility/cupertino_context_extension.dart';
import 'package:nonoprice/utility/image_extension.dart';

import '../../shared/constant.dart';
import '../../shared/widget/loading_error_page_ios.dart';
import '../model/product_overview_item.dart';

class ProductListIOS extends StatefulWidget {
  const ProductListIOS({Key? key}) : super(key: key);

  @override
  State<ProductListIOS> createState() => _ProductListIOSState();
}

class _ProductListIOSState extends State<ProductListIOS> {
  @override
  Widget build(BuildContext context) {
    String categoryId = ModalRoute.of(context)?.settings.arguments as String;
    context.read<ProductListCubit>().getProductList(categoryId);

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CupertinoNavigationBar(
              middle: BlocBuilder<ProductListCubit, ProductListState>(
                  buildWhen: (prev, current) {
                return current is ProductOverviewList;
              }, builder: (context, state) {
                String title =
                    state is ProductOverviewList ? state.pageTitle : 'Products';
                return Text(title);
              }),
            ),
          ),
          const SliverFillRemaining(
            fillOverscroll: true,
            child: _ProductListArea(),
          ),
        ],
      ),
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
              ? LoadingPageIOS(
                  message: state.message,
                )
              : state is LoadingProductListFailure
                  ? LoadingErrorPageIOS(
                      errorTitle: state.title,
                      errorMessage: state.message,
                      onRetry: () {
                        String categoryId = ModalRoute.of(context)
                            ?.settings
                            .arguments as String;
                        context
                            .read<ProductListCubit>()
                            .getProductList(categoryId);
                      })
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
                        ? const CupertinoActivityIndicator(
                            radius: 8.0,
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
