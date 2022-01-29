import 'package:flutter/cupertino.dart';
import 'package:weight_calculator/constants.dart';

class WeightCalculator extends ChangeNotifier {
  double bmi = 0.0;
  int height = 180;
  int weight = 60;
  int age = 20;
  Sex gender = Sex.male;

  void changeGender(Sex newGender) {
    gender = newGender;
    notifyListeners();
  }

  void incrementAge() {
    age++;
    notifyListeners();
  }

  void decrementAge() {
    age--;
    notifyListeners();
  }

  void incrementWeight() {
    weight++;
    notifyListeners();
  }

  void decrementWeight() {
    weight--;
    notifyListeners();
  }

  void changeHeight(int newHeight) {
    height = newHeight;
    notifyListeners();
  }
}
