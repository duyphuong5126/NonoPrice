import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nonoprice/presentation/android/home_page_android.dart';

import 'di/dependency_manager.dart';

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
    return MaterialApp(
      home: const HomePageAndroid(),
      theme: ThemeData(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.grey[900],
          appBarTheme:
              const AppBarTheme(backgroundColor: Colors.white, elevation: 1.0),
          textTheme: GoogleFonts.nunitoTextTheme(textTheme)),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          backgroundColor: Colors.grey[900],
          scaffoldBackgroundColor: Colors.grey[900],
          primaryColor: Colors.white,
          appBarTheme:
              const AppBarTheme(backgroundColor: Colors.black, elevation: 0.0),
          textTheme: GoogleFonts.nunitoTextTheme(textTheme)),
    );
  }
}
