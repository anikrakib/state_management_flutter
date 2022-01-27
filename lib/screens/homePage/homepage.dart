import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weight_calculator/calculation.dart';
import 'package:weight_calculator/constants.dart';
import 'package:weight_calculator/screens/homePage/component/bottom_button.dart';
import 'package:weight_calculator/screens/homePage/component/icon_content.dart';
import 'package:weight_calculator/screens/homePage/component/reusable_card.dart';
import 'package:weight_calculator/screens/result/result_page.dart';

enum Sex { Male, Female }

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int height = 180;
  int weight = 60;
  int age = 20;
  Sex choice = Sex.Male;
  Color maleCardColor = kActiveCardColor;
  Color femaleCardColor = kInactiveCardColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title.toUpperCase()),
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        return SafeArea(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.only(bottom: 80),
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
                              color: choice == Sex.Male
                                  ? kActiveCardColor
                                  : kInactiveCardColor,
                              child: const IconContent(
                                label: "Male",
                                icon: FontAwesomeIcons.mars,
                              ),
                              onTap: () => changeGender(Sex.Male),
                            ),
                          ),
                          Expanded(
                            child: ReUsableCard(
                              color: choice == Sex.Female
                                  ? kActiveCardColor
                                  : kInactiveCardColor,
                              child: const IconContent(
                                label: "Female",
                                icon: FontAwesomeIcons.venus,
                              ),
                              onTap: () => changeGender(Sex.Female),
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
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    '$height',
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
                                  overlayShape: const RoundSliderOverlayShape(
                                    overlayRadius: 30.0,
                                  ),
                                  thumbColor: Colors.deepOrange,
                                  overlayColor: Colors.deepOrange.shade900,
                                  activeTrackColor: Colors.white,
                                  inactiveTrackColor: const Color(0xFF8D8E98),
                                ),
                                child: Slider(
                                    value: height.toDouble(),
                                    min: kSliderMin,
                                    max: kSliderMax,
                                    //divisions: (kSliderMax - kSliderMin).toInt(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        height = newValue.toInt();
                                      });
                                    }
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
                                padding: const EdgeInsets.all(kCardMargin * 2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'WEIGHT',
                                      style: kLabelTextStyle,
                                    ),
                                    Text(
                                      '$weight',
                                      style: kLargeNumberLabelTextStyle,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RawMaterialButton(
                                          child:
                                              const Icon(FontAwesomeIcons.plus),
                                          onPressed: incrementWeight,
                                          constraints:
                                              kRoundIconButtonConstraints,
                                          shape: const CircleBorder(),
                                          fillColor: kRoundIconButtonColor,
                                        ),
                                        const SizedBox(width: labelIconSpacing),
                                        RawMaterialButton(
                                          child: const Icon(
                                              FontAwesomeIcons.minus),
                                          onPressed: () {
                                            weight != 0
                                                ? decrementWeight()
                                                : showSnackBar(
                                                    'Weight Can\'t be Empty',
                                                    context);
                                          },
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
                                padding: const EdgeInsets.all(kCardMargin * 2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'AGE',
                                      style: kLabelTextStyle,
                                    ),
                                    Text(
                                      '$age',
                                      style: kLargeNumberLabelTextStyle,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RawMaterialButton(
                                          child:
                                              const Icon(FontAwesomeIcons.plus),
                                          onPressed: incrementAge,
                                          constraints:
                                              kRoundIconButtonConstraints,
                                          shape: const CircleBorder(),
                                          fillColor: kRoundIconButtonColor,
                                        ),
                                        const SizedBox(width: labelIconSpacing),
                                        RawMaterialButton(
                                          child: const Icon(
                                              FontAwesomeIcons.minus),
                                          onPressed: () {
                                            age != 0
                                                ? decrementAge()
                                                : showSnackBar(
                                                    'Age Can\'t be empty',
                                                    context);
                                          },
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
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: BottomButton(
                      label: 'CALCULATE',
                      onPress: () {
                        var calulation =
                            Calculator(height: height, weight: weight);

                        final bmi = calulation.calculate();
                        final result = calulation.getResult();
                        final interpretation = calulation.getInterpretation();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultPage(
                                  bmi: bmi,
                                  result: result,
                                  interpretation: interpretation)),
                        );
                      }),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  void changeGender(Sex gender) {
    return setState(() {
      choice = gender;
    });
  }

  void incrementWeight() {
    return setState(() {
      weight++;
    });
  }

  void decrementWeight() {
    return setState(() {
      weight--;
    });
  }

  void incrementAge() {
    return setState(() {
      age++;
    });
  }

  void decrementAge() {
    //print('$age');
    return setState(() {
      age--;
    });
  }

  void showSnackBar(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 24),
      ),
      backgroundColor: kActiveCardColor,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 700),
    ));
  }
}
