import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weight_calculator/bloc_state_management/bloc/weight_calculator.dart';
import 'package:weight_calculator/component/bottom_button.dart';
import 'package:weight_calculator/component/icon_content.dart';
import 'package:weight_calculator/component/reusable_card.dart';
import 'package:weight_calculator/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _weightCalculatorBloc = WeightCalculatorBloc();

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
                  padding: const EdgeInsets.only(bottom: kCardMargin * 8),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        StreamBuilder<Sex>(
                            stream: _weightCalculatorBloc.genderStream,
                            initialData: Sex.male,
                            builder: (context, snapshot) {
                              return Row(
                                children: [
                                  Expanded(
                                      child: ReUsableCard(
                                    color: snapshot.data == Sex.male
                                        ? kActiveCardColor
                                        : kInactiveCardColor,
                                    child: const IconContent(
                                      label: "Male",
                                      icon: FontAwesomeIcons.mars,
                                    ),
                                    onTap: () => _weightCalculatorBloc
                                        .changeGender(Sex.male),
                                  )),
                                  Expanded(
                                    child: ReUsableCard(
                                      color: snapshot.data == Sex.female
                                          ? kActiveCardColor
                                          : kInactiveCardColor,
                                      child: const IconContent(
                                        label: "Female",
                                        icon: FontAwesomeIcons.venus,
                                      ),
                                      onTap: () => _weightCalculatorBloc
                                          .changeGender(Sex.female),
                                    ),
                                  ),
                                ],
                              );
                            }),
                        ReUsableCard(
                          color: kActiveCardColor,
                          child: Padding(
                            padding: const EdgeInsets.only(top: kCardMargin),
                            child: StreamBuilder<int>(
                                stream: _weightCalculatorBloc.heightStream,
                                initialData: 180,
                                builder: (context, snapshot) {
                                  return Column(
                                    children: [
                                      const Text(
                                        "HEIGHT",
                                        style: kLabelTextStyle,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Text(
                                            '${snapshot.data}',
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
                                          thumbShape:
                                              const RoundSliderThumbShape(
                                            enabledThumbRadius: 15.0,
                                          ),
                                          overlayShape:
                                              const RoundSliderOverlayShape(
                                            overlayRadius: 30.0,
                                          ),
                                          thumbColor: Colors.deepOrange,
                                          overlayColor:
                                              Colors.deepOrange.shade900,
                                          activeTrackColor: Colors.white,
                                          inactiveTrackColor:
                                              const Color(0xFF8D8E98),
                                        ),
                                        child: Slider(
                                            value: snapshot.data!.toDouble(),
                                            min: kSliderMin,
                                            max: kSliderMax,
                                            //divisions: (kSliderMax - kSliderMin).toInt(),
                                            onChanged: (newValue) => {
                                                  _weightCalculatorBloc
                                                      .changeHeight(
                                                          newValue.toInt())
                                                }
                                            //ChangeHeight(newValue.toInt()),
                                            ),
                                      )
                                    ],
                                  );
                                }),
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
                                        StreamBuilder(
                                            stream: _weightCalculatorBloc
                                                .weightStream,
                                            initialData: 60,
                                            builder: (context, snapshot) {
                                              return Text(
                                                '${snapshot.data}',
                                                style:
                                                    kLargeNumberLabelTextStyle,
                                              );
                                            }),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            RawMaterialButton(
                                              child: const Icon(
                                                  FontAwesomeIcons.plus),
                                              onPressed: () =>
                                                  _weightCalculatorBloc
                                                      .eventSink
                                                      .add(EventAction
                                                          .weightIncrement),
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
                                                  _weightCalculatorBloc
                                                      .eventSink
                                                      .add(EventAction
                                                          .weightDecrement),
                                              constraints:
                                                  kRoundIconButtonConstraints,
                                              shape: const CircleBorder(),
                                              fillColor: kRoundIconButtonColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'AGE',
                                        style: kLabelTextStyle,
                                      ),
                                      StreamBuilder(
                                          stream:
                                              _weightCalculatorBloc.ageStream,
                                          initialData: 20,
                                          builder: (context, snapshot) {
                                            return Text(
                                              '${snapshot.data}',
                                              style: kLargeNumberLabelTextStyle,
                                            );
                                          }),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          RawMaterialButton(
                                            child: const Icon(
                                                FontAwesomeIcons.plus),
                                            onPressed: () =>
                                                _weightCalculatorBloc.eventSink
                                                    .add(EventAction
                                                        .ageIncrement),
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
                                                _weightCalculatorBloc.eventSink
                                                    .add(EventAction
                                                        .ageDecrement),
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
                        Navigator.pushNamed(context, '/result', arguments: {
                          'title': widget.title,
                          'cal': _weightCalculatorBloc.calculation()
                        });
                      }),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _weightCalculatorBloc.dispose();
    super.dispose();
  }
}
