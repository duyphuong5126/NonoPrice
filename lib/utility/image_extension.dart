import 'package:flutter/painting.dart';

extension ImageChunkEventExtension on ImageChunkEvent {
  bool get isLoadingFinished =>
      cumulativeBytesLoaded >= (expectedTotalBytes ?? 0);
}
