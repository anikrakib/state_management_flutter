import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weight_calculator/bloc_state_management/bloc/weight_calculator.dart';
import 'package:weight_calculator/calculation.dart';
import 'package:weight_calculator/component/bottom_button.dart';
import 'package:weight_calculator/component/reusable_card.dart';
import 'package:weight_calculator/constants.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late WeightCalculatorBloc _weightCalculatorBloc;

  @override
  void initState() {
    _weightCalculatorBloc = WeightCalculatorBloc();
    super.initState();
  }

  @override
  void dispose() {
    _weightCalculatorBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    Calculation cal = arguments['cal'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            FontAwesomeIcons.angleLeft,
          ),
        ),
        title: Text(
          arguments['title'].toUpperCase(),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * .9,
              padding: const EdgeInsets.only(bottom: kCardMargin * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Results",
                    style: kLargeNumberLabelTextStyle,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: kCardMargin * 8),
                      child: ReUsableCard(
                        color: kActiveCardColor,
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                cal.getResult(),
                                style: kResultsTextStyle,
                              ),
                              Text(
                                cal.calculate(),
                                style: kAppBarTitleTextStyle,
                              ),
                              Text(
                                cal.getInterpretation(),
                                style: kBodyTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
                  label: 'RE-CALCULATE',
                  onPress: () {
                    Navigator.pop(context);
                    //providerData.height = providerData.age;
                  }),
            ),
          )
        ],
      ),
    );
  }
}
