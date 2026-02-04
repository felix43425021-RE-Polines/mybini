import 'package:flutter/material.dart';
import 'package:mybini/helper/size.dart';

const bp = {'xs': 0, 'sm': 576, 'md': 768, 'lg': 992, 'xl': 1200, 'xxl': 1400};

bool isXS(BuildContext context) {
  return width(context) >= bp["xs"]! && width(context) < bp["sm"]!;
}

bool isSM(BuildContext context) {
  return width(context) >= bp["sm"]! && width(context) < bp["md"]!;
}

bool isMD(BuildContext context) {
  return width(context) >= bp["md"]! && width(context) < bp["lg"]!;
}

bool isLG(BuildContext context) {
  return width(context) >= bp["lg"]! && width(context) < bp["xl"]!;
}

bool isXL(BuildContext context) {
  return width(context) >= bp["xl"]! && width(context) < bp["xxl"]!;
}

bool isXXL(BuildContext context) {
  return width(context) >= bp["xxl"]!;
}

bool isPortrait(BuildContext context) {
  return isXS(context) || isSM(context) || isMD(context);
}

bool isLandscape(BuildContext context) {
  return isLG(context) || isXL(context) || isXXL(context);
}
