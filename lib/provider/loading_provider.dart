import 'package:flutter/foundation.dart';

class LoadingProvider extends ChangeNotifier {
  bool isLoading = false;

  LoadingProvider();

  void updateLoading() {
    this.isLoading = !isLoading;
    notifyListeners();
  }
}
