import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:weight_calculator/constants.dart';

class InputController extends GetxController {
  RxInt bmi = 0.obs;
  RxInt height = 180.obs;
  RxInt weight = 60.obs;
  RxInt age = 20.obs;
  Rx<Sex> choice = Sex.male.obs;

  RxBool isSelected = false.obs;

  void incrementAge() => age.value++;
  void decrementAge() => age.value--;
  void incrementWeight() => weight.value++;
  void decrementWeight() => weight.value--;
  void chnageColor() => isSelected.value = !isSelected.value;
  Color getCardColor({bool selected = false}) {
    return selected ? kActiveCardColor : kInactiveCardColor;
  }

  void changeHeight(int heightNewvalue) => height.value = heightNewvalue;
  void changeGender(Sex gender) => choice.value = gender;
}
