import 'package:flutter/material.dart';
// return screen size
Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

// get screen height and reduce the size
double screenHeight(BuildContext context,
    {double reducedBy = 0, double dividedBy = 1}) {
  return (screenSize(context).height - reducedBy) / dividedBy;
}
// get the screen width
double screenWidth(BuildContext context,
    {double dividedBy = 1, double reducedBy = 0.0}) {
  return (screenSize(context).width - reducedBy) / dividedBy;
}

// get screen height without toolbar.
double screenHeightExcludingToolbar(BuildContext context,
    {double dividedBy = 1}) {
  return screenHeight(context, dividedBy: dividedBy, reducedBy: kToolbarHeight);
}
