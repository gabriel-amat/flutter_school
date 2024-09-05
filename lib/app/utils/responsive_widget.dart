import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget smallScreen;
  final Widget? mediumScreen;
  final Widget? largeScreen;

  const ResponsiveWidget({
    super.key,
    required this.smallScreen,
    this.mediumScreen,
    this.largeScreen,
  });

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1200;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  @override
  Widget build(BuildContext context) {
    if (isLargeScreen(context)) {
      return largeScreen ?? mediumScreen ?? smallScreen;
    } else if (isMediumScreen(context)) {
      return mediumScreen ?? smallScreen;
    } else {
      return smallScreen;
    }
  }
}
