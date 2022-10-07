import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nonoprice/utility/material_context_extension.dart';

import '../../di/dependency_manager.dart';
import '../../utility/log.dart';
import '../home_cubit.dart';
import '../model/home_state.dart';
import '../model/product_category_uimodel.dart';

class HomePageAndroid extends StatefulWidget {
  const HomePageAndroid({Key? key}) : super(key: key);

  @override
  State<HomePageAndroid> createState() => _HomePageAndroidState();
}

class _HomePageAndroidState extends State<HomePageAndroid> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              DependencyManager.get<HomeCubit>()..getCategoryList(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<HomeCubit, HomeState>(buildWhen: (prev, current) {
            return current is HomeTitle;
          }, builder: (context, state) {
            String title = state is HomeTitle ? state.title : 'Welcome';
            return Text(
              title,
              style: TextStyle(inherit: true, color: context.mainColor),
            );
          }),
        ),
        body: _HomePageBody(safeAreaHeight: context.safeAreaHeight),
      ),
    );
  }
}

/// Start region of Home page's Body
class _HomePageBody extends StatefulWidget {
  final double safeAreaHeight;

  const _HomePageBody({Key? key, required this.safeAreaHeight})
      : super(key: key);

  @override
  State<_HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<_HomePageBody> with LogMixin {
  @override
  Widget build(BuildContext context) {
    double categoryItemHeight = widget.safeAreaHeight / 2;
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return state is HomeProductCategories
          ? _CategoryList(
              state: state,
              itemHeight: categoryItemHeight,
            )
          : state is HomeLoadingCategoriesFailure
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.message,
                        style: context.titleLarge,
                      ),
                      IconButton(
                          icon: const Icon(
                            Icons.refresh,
                            size: 32,
                          ),
                          onPressed: () {
                            context.read<HomeCubit>().getCategoryList();
                          })
                    ],
                  ),
                )
              : const Center(
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(),
                  ),
                );
    });
  }
}

class _CategoryList extends StatelessWidget {
  final HomeProductCategories state;
  final double itemHeight;

  const _CategoryList({Key? key, required this.state, required this.itemHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
              child: Text(
                state.header,
                style:
                    context.titleLarge?.copyWith(color: context.primaryColor),
              ),
            ),
          ),
          SliverGrid(
              delegate: SliverChildBuilderDelegate(
                  childCount: state.categories.length, (context, index) {
                return _ProductCategory(
                    model: state.categories.elementAt(index),
                    height: itemHeight,
                    onCategorySelected: (category) {});
              }),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0))
        ],
      ),
    );
  }
}

class _ProductCategory extends StatelessWidget {
  final double height;
  final ProductCategoryUiModel model;
  final Function(String) onCategorySelected;

  const _ProductCategory(
      {Key? key,
      required this.model,
      required this.height,
      required this.onCategorySelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color cardColor =
        !context.isDark ? Colors.grey[300]! : context.backgroundColor;
    Color cardBorderColor =
        !context.isDark ? Colors.grey[300]! : context.primaryColor;

    return InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        onTap: () => onCategorySelected(model.categoryId),
        child: Ink(
          padding: const EdgeInsets.all(4.0),
          height: height,
          decoration: BoxDecoration(
              color: cardColor,
              border: Border.all(color: cardBorderColor),
              borderRadius: const BorderRadius.all(Radius.circular(16.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                model.name,
                textAlign: TextAlign.center,
                style: context.headlineSmall
                    ?.copyWith(color: context.primaryColor),
              ),
              Text(
                model.countText,
                textAlign: TextAlign.center,
                style: context.bodyLarge?.copyWith(color: context.primaryColor),
              )
            ],
          ),
        ));
  }
}

/// End region of Home page's Body
