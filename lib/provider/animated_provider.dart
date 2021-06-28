import 'package:flutter/material.dart';

class AnimatedProvider extends ChangeNotifier {
  bool isAnimated = false;
  AnimatedProvider():isAnimated = false;

  void setIsAnimated() {
    this.isAnimated = !isAnimated;
    notifyListeners();
  }
  void updateAnimated(bool isAnimated) {
    this.isAnimated = isAnimated;
    notifyListeners();
  }
}