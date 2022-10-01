import 'package:flutter/painting.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get inheritTextStyle => copyWith(inherit: true);
}
