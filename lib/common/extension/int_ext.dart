import 'package:flutter/cupertino.dart';

extension SizeboxExt on int {
  Widget get sizedBoxH {
    return SizedBox(
      height: toDouble(),
    );
  }

  Widget get sizedBoxW {
    return SizedBox(
      width: toDouble(),
    );
  }
}