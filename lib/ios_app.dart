import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nonoprice/presentation/ios/home_page_ios.dart';

class NonoPriceIOS extends StatefulWidget {
  const NonoPriceIOS({Key? key}) : super(key: key);

  @override
  State<NonoPriceIOS> createState() => _NonoPriceIOSState();
}

class _NonoPriceIOSState extends State<NonoPriceIOS> {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: const HomePageIOS(),
      theme: CupertinoThemeData(
          barBackgroundColor: const CupertinoDynamicColor.withBrightness(
              color: CupertinoColors.white, darkColor: CupertinoColors.black),
          scaffoldBackgroundColor: const CupertinoDynamicColor.withBrightness(
              color: CupertinoColors.white, darkColor: CupertinoColors.black),
          primaryColor: CupertinoDynamicColor.withBrightness(
              color: Colors.grey[900] ?? CupertinoColors.black,
              darkColor: CupertinoColors.white)),
    );
  }
}
