import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:nonoprice/android_app.dart';
import 'package:nonoprice/ios_app.dart';

void main() {
  runApp(Platform.isIOS ? const NonoPriceIOS() : const NonoPriceAndroid());
}
