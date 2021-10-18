import 'package:flutter/cupertino.dart';

class SelectBottomNavigationProvider extends ChangeNotifier {
  int routeIndex = 0;

  SelectBottomNavigationProvider({
    routeIndex = 0,
  });

  void selectBottomNavigation(int routeIndex) {
    this.routeIndex = routeIndex;
    notifyListeners();
  }
}
