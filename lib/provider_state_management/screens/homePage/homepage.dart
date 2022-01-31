import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weight_calculator/component/bottom_button.dart';
import 'package:weight_calculator/component/icon_content.dart';
import 'package:weight_calculator/component/reusable_card.dart';
import 'package:weight_calculator/constants.dart';
import 'package:weight_calculator/provider_state_management/provider/weight_calculator.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(title.toUpperCase()),
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        return SafeArea(
          child: Consumer<WeightCalculatorProvider>(
            builder: (_, provideData, __) => Stack(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.only(bottom: kCardMargin * 8),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ReUsableCard(
                                  color: provideData.gender == Sex.male
                                      ? kActiveCardColor
                                      : kInactiveCardColor,
                                  child: const IconContent(
                                    label: "Male",
                                    icon: FontAwesomeIcons.mars,
                                  ),
                                  onTap: () =>
                                      provideData.changeGender(Sex.male),
                                ),
                              ),
                              Expanded(
                                child: ReUsableCard(
                                  color: provideData.gender == Sex.female
                                      ? kActiveCardColor
                                      : kInactiveCardColor,
                                  child: const IconContent(
                                    label: "Female",
                                    icon: FontAwesomeIcons.venus,
                                  ),
                                  onTap: () =>
                                      provideData.changeGender(Sex.female),
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
                                        provideData.height.toString(),
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
                                        value: provideData.height.toDouble(),
                                        min: kSliderMin,
                                        max: kSliderMax,
                                        //divisions: (kSliderMax - kSliderMin).toInt(),
                                        onChanged: (newValue) => provideData
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
                                          provideData.weight.toString(),
                                          style: kLargeNumberLabelTextStyle,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            RawMaterialButton(
                                              child: const Icon(
                                                  FontAwesomeIcons.plus),
                                              onPressed: () =>
                                                  provideData.incrementWeight(),
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
                                              onPressed: () =>
                                                  provideData.decrementWeight(),
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
                                          provideData.age.toString(),
                                          style: kLargeNumberLabelTextStyle,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            RawMaterialButton(
                                              child: const Icon(
                                                  FontAwesomeIcons.plus),
                                              onPressed: () =>
                                                  provideData.incrementAge(),
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
                                              onPressed: () =>
                                                  provideData.decrementAge(),
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
                    )),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: BottomButton(
                        label: 'CALCULATE',
                        onPress: () {
                          Navigator.pushNamed(context, '/result',
                              arguments: {'title': title});
                        }),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
