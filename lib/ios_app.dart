import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nonoprice/presentation/ios/home_page_ios.dart';
import 'package:nonoprice/presentation/ios/product_list_ios.dart';

import 'di/dependency_manager.dart';
import 'presentation/home_cubit.dart';
import 'presentation/product_list_cubit.dart';
import 'shared/constant.dart';

class NonoPriceIOS extends StatefulWidget {
  const NonoPriceIOS({Key? key}) : super(key: key);

  @override
  State<NonoPriceIOS> createState() => _NonoPriceIOSState();
}

class _NonoPriceIOSState extends State<NonoPriceIOS> {
  @override
  void initState() {
    super.initState();
    DependencyManager.init();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DependencyManager.get<HomeCubit>(),
          ),
          BlocProvider(
            create: (context) => DependencyManager.get<ProductListCubit>(),
          )
        ],
        child: CupertinoApp(
          theme: CupertinoThemeData(
              barBackgroundColor: const CupertinoDynamicColor.withBrightness(
                  color: CupertinoColors.white,
                  darkColor: CupertinoColors.black),
              scaffoldBackgroundColor:
                  const CupertinoDynamicColor.withBrightness(
                      color: CupertinoColors.white,
                      darkColor: CupertinoColors.black),
              primaryColor: CupertinoDynamicColor.withBrightness(
                  color: Colors.grey[900] ?? CupertinoColors.black,
                  darkColor: CupertinoColors.white)),
          routes: {
            '/': (context) => const HomePageIOS(),
            productListRoute: (context) => const ProductListIOS(),
          },
        ));
  }
}
