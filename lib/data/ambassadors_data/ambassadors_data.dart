import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import '../../generated/l10n.dart';

class AmbassadorsData {
  final Image image;
  final String title;

  AmbassadorsData(this.image, this.title);
}

List ambassadorsData = [
  AmbassadorsData(Image.asset(Assets.imageStarbucks), S.current.starbucks),
  AmbassadorsData(Image.asset(Assets.imageLenovo), S.current.lenovo),
  AmbassadorsData(Image.asset(Assets.imageAppleLogo), S.current.apple),
  AmbassadorsData(Image.asset(Assets.imageStarbucks), S.current.tata),
];
