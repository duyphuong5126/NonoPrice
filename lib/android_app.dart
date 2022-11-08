import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nonoprice/presentation/android/home_page_android.dart';
import 'package:nonoprice/presentation/android/price_collection_page_android.dart';
import 'package:nonoprice/presentation/android/product_list_android.dart';
import 'package:nonoprice/shared/constant.dart';

import 'di/dependency_manager.dart';
import 'presentation/home_cubit.dart';
import 'presentation/product_list_cubit.dart';

class NonoPriceAndroid extends StatefulWidget {
  const NonoPriceAndroid({Key? key}) : super(key: key);

  @override
  State<NonoPriceAndroid> createState() => _NonoPriceAndroidState();
}

class _NonoPriceAndroidState extends State<NonoPriceAndroid> {
  @override
  void initState() {
    super.initState();
    DependencyManager.init();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DependencyManager.get<HomeCubit>(),
        ),
        BlocProvider(
          create: (context) => DependencyManager.get<ProductListCubit>(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.grey[200],
          primaryColor: Colors.grey[900],
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 1.0,
              iconTheme: IconThemeData(color: Colors.grey[900])),
          textTheme: GoogleFonts.nunitoTextTheme(textTheme),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          backgroundColor: Colors.grey[900],
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.white,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.white)),
          textTheme: GoogleFonts.nunitoTextTheme(textTheme),
        ),
        routes: {
          '/': (context) => const HomePageAndroid(),
          productListRoute: (context) => const ProductListAndroid(),
          priceListRoute: (context) => const PriceCollectionPageAndroid(),
        },
      ),
    );
  }
}
