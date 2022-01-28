import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:weight_calculator/component/bottom_button.dart';
import 'package:weight_calculator/component/icon_content.dart';
import 'package:weight_calculator/component/reusable_card.dart';
import 'package:weight_calculator/constants.dart';
import 'package:weight_calculator/getx_state_management/controller/input_controller.dart';
import 'package:weight_calculator/getx_state_management/screens/result/result_page.dart';

import '../../../calculation.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    InputController inputController = Get.put(InputController());
    print('create');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(title.toUpperCase()),
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        return SafeArea(
          child: Stack(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.only(bottom: kCardMargin * 8),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ReUsableCard(
                                  color:
                                      inputController.choice.value == Sex.male
                                          ? kActiveCardColor
                                          : kInactiveCardColor,
                                  child: const IconContent(
                                    label: "Male",
                                    icon: FontAwesomeIcons.mars,
                                  ),
                                  onTap: () =>
                                      inputController.changeGender(Sex.male),
                                ),
                              ),
                              Expanded(
                                child: ReUsableCard(
                                  color:
                                      inputController.choice.value == Sex.female
                                          ? kActiveCardColor
                                          : kInactiveCardColor,
                                  child: const IconContent(
                                    label: "Female",
                                    icon: FontAwesomeIcons.venus,
                                  ),
                                  onTap: () =>
                                      inputController.changeGender(Sex.female),
                                ),
                              ),
                            ],
                          ),
                          ReUsableCard(
                            color: kActiveCardColor,
                            child: Padding(
                              padding: const EdgeInsets.only(top: kCardMargin),
                              child: Column(
                                children: [
                                  const Text(
                                    "HEIGHT",
                                    style: kLabelTextStyle,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        inputController.height.value.toString(),
                                        style: kLargeNumberLabelTextStyle,
                                      ),
                                      const Text(
                                        "cm",
                                        style: kLabelTextStyle,
                                      ),
                                    ],
                                  ),
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 15.0,
                                      ),
                                      overlayShape:
                                          const RoundSliderOverlayShape(
                                        overlayRadius: 30.0,
                                      ),
                                      thumbColor: Colors.deepOrange,
                                      overlayColor: Colors.deepOrange.shade900,
                                      activeTrackColor: Colors.white,
                                      inactiveTrackColor:
                                          const Color(0xFF8D8E98),
                                    ),
                                    child: Slider(
                                        value: inputController.height.value
                                            .toDouble(),
                                        min: kSliderMin,
                                        max: kSliderMax,
                                        //divisions: (kSliderMax - kSliderMin).toInt(),
                                        onChanged: (newValue) => inputController
                                            .changeHeight(newValue.toInt())
                                        //ChangeHeight(newValue.toInt()),
                                        ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ReUsableCard(
                                  color: kActiveCardColor,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(kCardMargin * 2),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'WEIGHT',
                                          style: kLabelTextStyle,
                                        ),
                                        Text(
                                          inputController.weight.value
                                              .toString(),
                                          style: kLargeNumberLabelTextStyle,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            RawMaterialButton(
                                              child: const Icon(
                                                  FontAwesomeIcons.plus),
                                              onPressed: () => inputController
                                                  .incrementWeight(),
                                              constraints:
                                                  kRoundIconButtonConstraints,
                                              shape: const CircleBorder(),
                                              fillColor: kRoundIconButtonColor,
                                            ),
                                            const SizedBox(
                                                width: labelIconSpacing),
                                            RawMaterialButton(
                                              child: const Icon(
                                                  FontAwesomeIcons.minus),
                                              onPressed: () => inputController
                                                  .decrementWeight(),
                                              constraints:
                                                  kRoundIconButtonConstraints,
                                              shape: const CircleBorder(),
                                              fillColor: kRoundIconButtonColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                              Expanded(
                                child: ReUsableCard(
                                  color: kActiveCardColor,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(kCardMargin * 2),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'AGE',
                                          style: kLabelTextStyle,
                                        ),
                                        Text(
                                          inputController.age.value.toString(),
                                          style: kLargeNumberLabelTextStyle,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            RawMaterialButton(
                                              child: const Icon(
                                                  FontAwesomeIcons.plus),
                                              onPressed: () => inputController
                                                  .incrementAge(),
                                              constraints:
                                                  kRoundIconButtonConstraints,
                                              shape: const CircleBorder(),
                                              fillColor: kRoundIconButtonColor,
                                            ),
                                            const SizedBox(
                                                width: labelIconSpacing),
                                            RawMaterialButton(
                                              child: const Icon(
                                                  FontAwesomeIcons.minus),
                                              onPressed: () => inputController
                                                  .decrementAge(),
                                              constraints:
                                                  kRoundIconButtonConstraints,
                                              shape: const CircleBorder(),
                                              fillColor: kRoundIconButtonColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: BottomButton(
                      label: 'CALCULATE',
                      onPress: () {
                        Get.toNamed('/result', arguments: {'title': title});
                      }),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
