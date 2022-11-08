import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nonoprice/domain/entity/product.dart';
import 'package:nonoprice/presentation/price_collection_page_cubit.dart';
import 'package:nonoprice/utility/material_context_extension.dart';

import '../../di/dependency_manager.dart';
import '../../shared/constant.dart';
import '../model/price_collection_state.dart';
import '../model/price_uimodel.dart';

class PriceCollectionPageAndroid extends StatelessWidget {
  const PriceCollectionPageAndroid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)?.settings.arguments as Product;
    return BlocProvider<PriceCollectionPageCubit>(
      create: (context) => DependencyManager.get<PriceCollectionPageCubit>()
        ..init(
          product: product,
        ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            product.name,
            style: TextStyle(
              inherit: true,
              color: context.primaryColor,
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: normalSpace,
                ),
                child: AspectRatio(
                  aspectRatio: 16.0 / 9,
                  child: CachedNetworkImage(
                    imageUrl: product.photoUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Container(
                      color: Colors.white,
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child:
                  BlocBuilder<PriceCollectionPageCubit, PriceCollectionState>(
                buildWhen: (prev, current) {
                  return current is ProductOverview;
                },
                builder: (context, state) {
                  return state is ProductOverview
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: normalSpace,
                            vertical: mediumSpace,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.priceRange,
                                style: context.titleLarge
                                    ?.copyWith(color: context.primaryColor),
                              ),
                              const SizedBox(
                                height: mediumSpace,
                              ),
                              Text(
                                state.updatedAt,
                                style: context.titleSmall
                                    ?.copyWith(color: context.primaryColor),
                              ),
                              const SizedBox(
                                height: mediumSpace,
                              ),
                              _BestChoice(
                                title: state.lowestPriceTitle,
                                bestPrice: state.lowestPrice,
                                bestPriceInfo: state.lowestPriceInfo,
                              ),
                              const SizedBox(
                                height: normalSpace,
                              ),
                            ],
                          ),
                        )
                      : Container();
                },
              ),
            ),
            SliverToBoxAdapter(
              child:
                  BlocBuilder<PriceCollectionPageCubit, PriceCollectionState>(
                buildWhen: (prev, current) {
                  return current is ProductPriceGroups;
                },
                builder: (context, state) {
                  if (state is ProductPriceGroups) {
                    List<Widget> priceGroups = [
                      Text(
                        state.otherChoicesTitle,
                        style: context.titleLarge?.copyWith(
                          color: context.primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: mediumSpace,
                      ),
                    ];
                    state.priceGroups.forEach(
                      (groupName, priceItems) {
                        priceGroups.add(
                          Text(
                            groupName,
                            style: context.titleMedium
                                ?.copyWith(color: context.primaryColor),
                          ),
                        );
                        for (int index = 0;
                            index < priceItems.length;
                            index++) {
                          priceGroups.add(
                            _PriceItem(
                              item: priceItems.elementAt(index),
                            ),
                          );
                          if (index < priceItems.length - 1) {
                            priceGroups.add(
                              const SizedBox(
                                height: smallSpace,
                              ),
                            );
                          }
                        }
                        priceGroups.add(
                          const SizedBox(
                            height: normalSpace,
                          ),
                        );
                      },
                    );
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: normalSpace,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: priceGroups,
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BestChoice extends StatelessWidget {
  final String title;
  final String bestPrice;
  final String bestPriceInfo;

  const _BestChoice({
    Key? key,
    required this.title,
    required this.bestPrice,
    required this.bestPriceInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.titleLarge?.copyWith(
            color: context.primaryColor,
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: mediumSpace,
            horizontal: normalSpace,
          ),
          decoration: BoxDecoration(
            color: context.defaultCardColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(
                8.0,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        bestPrice,
                        style: context.headlineSmall?.copyWith(
                          inherit: true,
                          color: context.mainColor,
                        ),
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    icCrown,
                    width: largeIconSize,
                    height: largeIconSize,
                    color: context.favoriteColor,
                  ),
                ],
              ),
              const SizedBox(
                height: smallSpace,
              ),
              Text(
                bestPriceInfo,
                style: context.bodyLarge?.copyWith(
                  inherit: true,
                  color: context.mainColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PriceItem extends StatelessWidget {
  final PriceItemUiModel item;

  const _PriceItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: mediumSpace,
        horizontal: normalSpace,
      ),
      decoration: BoxDecoration(
        color: context.defaultCardColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            8.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.price,
            style: context.bodyLarge?.copyWith(color: context.primaryColor),
          ),
          Text(
            item.updatedAt,
            style: context.bodyMedium?.copyWith(color: context.primaryColor),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              item.groupName,
              style: context.bodySmall?.copyWith(color: context.primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
