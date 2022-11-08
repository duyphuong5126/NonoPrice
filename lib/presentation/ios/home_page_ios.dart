import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nonoprice/presentation/home_cubit.dart';
import 'package:nonoprice/presentation/model/product_category_uimodel.dart';
import 'package:nonoprice/utility/cupertino_context_extension.dart';
import 'package:nonoprice/utility/text_extension.dart';

import '../../shared/constant.dart';
import '../../shared/widget/loading_page_ios.dart';
import '../model/home_state.dart';

class HomePageIOS extends StatefulWidget {
  const HomePageIOS({Key? key}) : super(key: key);

  @override
  State<HomePageIOS> createState() => _HomePageIOSState();
}

class _HomePageIOSState extends State<HomePageIOS> {
  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().getCategoryList();
    return CupertinoPageScaffold(
        child: CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle:
              BlocBuilder<HomeCubit, HomeState>(buildWhen: (prev, current) {
            return current is HomeTitle;
          }, builder: (context, state) {
            String title = state is HomeTitle ? state.title : 'Welcome';
            return Text(
              title,
              style: GoogleFonts.nunito().inheritTextStyle.copyWith(
                    color: context.mainColor,
                  ),
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
    ));
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
    return BlocBuilder(
      bloc: context.read<HomeCubit>(),
      builder: (context, state) {
        return state is HomeProductCategories
            ? _CategoryList(state: state, itemHeight: categoryItemHeight)
            : state is HomeLoadingCategoriesFailure
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          state.message,
                          style: context.titleLarge,
                        ),
                        CupertinoButton(
                          child: const Icon(
                            CupertinoIcons.refresh_thick,
                            size: 32,
                          ),
                          onPressed: () {
                            context.read<HomeCubit>().getCategoryList();
                          },
                        )
                      ],
                    ),
                  )
                : const LoadingPageIOS();
      },
    );
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
                style: context.titleLarge.copyWith(
                  color: context.primaryColor,
                ),
              ),
            ),
          ),
          SliverGrid(
              delegate: SliverChildBuilderDelegate(
                  childCount: state.categories.length, (context, index) {
                return _ProductCategory(
                  model: state.categories.elementAt(index),
                  height: itemHeight,
                  onCategorySelected: (categoryId) {
                    Navigator.of(context)
                        .pushNamed(productListRoute, arguments: categoryId);
                  },
                );
              }),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ))
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
    return GestureDetector(
        onTap: () => onCategorySelected(model.categoryId),
        child: Container(
          padding: const EdgeInsets.all(4.0),
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.defaultCardColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(
                16.0,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                model.name,
                textAlign: TextAlign.center,
                style: context.headlineSmall.copyWith(
                  color: context.primaryColor,
                ),
              ),
              Text(
                model.countText,
                textAlign: TextAlign.center,
                style: context.bodyLarge.copyWith(
                  color: context.primaryColor,
                ),
              )
            ],
          ),
        ));
  }
}

/// End region of Home page's Body
