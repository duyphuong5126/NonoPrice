import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nonoprice/domain/entity/product_category.dart';
import 'package:nonoprice/presentation/home_categories_cubit.dart';
import 'package:nonoprice/presentation/model/product_category_uimodel.dart';
import 'package:nonoprice/utility/cupertino_context_extension.dart';
import 'package:nonoprice/utility/text_extension.dart';

import '../home_title_cubit.dart';
import '../model/home_state.dart';

class HomePageIOS extends StatefulWidget {
  const HomePageIOS({Key? key}) : super(key: key);

  @override
  State<HomePageIOS> createState() => _HomePageIOSState();
}

class _HomePageIOSState extends State<HomePageIOS> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCategoryListCubit()..init(),
          ),
          BlocProvider(
            create: (context) => HomeTitleCubit(),
          )
        ],
        child: CupertinoPageScaffold(
            child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: BlocBuilder<HomeTitleCubit, String>(
                  builder: (context, title) {
                return Text(
                  title,
                  style: GoogleFonts.nunito()
                      .inheritTextStyle
                      .copyWith(color: context.mainColor),
                );
              }),
              border: Border.all(color: context.barBackgroundColor),
            ),
            SliverFillRemaining(
              fillOverscroll: true,
              child: _HomePageBody(
                safeAreaHeight: context.safeAreaHeight,
              ),
            )
          ],
        )));
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

class _HomePageBodyState extends State<_HomePageBody> {
  @override
  Widget build(BuildContext context) {
    double categoryItemHeight = widget.safeAreaHeight / 2;
    return BlocBuilder<HomeCategoryListCubit, HomeCategoryListState>(
        buildWhen: (prevState, currentState) {
      return currentState is HomeProductCategories;
    }, builder: (context, state) {
      return state is HomeProductCategories
          ? Container(
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
                        style: context.titleLarge
                            .copyWith(color: context.primaryColor),
                      ),
                    ),
                  ),
                  SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                          childCount: state.categories.length,
                          (context, index) {
                        return _ProductCategory(
                            model: state.categories.elementAt(index),
                            height: categoryItemHeight,
                            onCategorySelected: (category) {});
                      }),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8.0,
                              crossAxisSpacing: 8.0))
                ],
              ),
            )
          : const Center(
              child: CupertinoActivityIndicator(
                radius: 16,
              ),
            );
    });
  }
}

class _ProductCategory extends StatelessWidget {
  final double height;
  final ProductCategoryUiModel model;
  final Function(ProductCategory) onCategorySelected;

  const _ProductCategory(
      {Key? key,
      required this.model,
      required this.height,
      required this.onCategorySelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onCategorySelected(model.category),
        child: Container(
          padding: const EdgeInsets.all(4.0),
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.all(Radius.circular(16.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                model.name,
                textAlign: TextAlign.center,
                style:
                    context.headlineSmall.copyWith(color: context.primaryColor),
              ),
              Text(
                model.countText,
                textAlign: TextAlign.center,
                style: context.bodyLarge.copyWith(color: context.primaryColor),
              )
            ],
          ),
        ));
  }
}

/*Container(
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: context.primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(16.0))),
          child: Text(
            model.name,
            style: context.bodyLarge.copyWith(color: context.primaryColor),
          ),
        )*/

/// End region of Home page's Body
