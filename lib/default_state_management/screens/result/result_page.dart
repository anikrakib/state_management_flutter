import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weight_calculator/constants.dart';
import 'package:weight_calculator/component/bottom_button.dart';
import 'package:weight_calculator/component/reusable_card.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({
    Key? key,
    required this.bmi,
    required this.result,
    required this.interpretation,
    required this.title,
  }) : super(key: key);

  final String bmi;
  final String title;
  final String result;
  final String interpretation;

  @override
  Widget build(BuildContext context) {
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
          title.toUpperCase(),
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
                          child: Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  result,
                                  style: kResultsTextStyle,
                                ),
                                Text(
                                  bmi,
                                  style: kAppBarTitleTextStyle,
                                ),
                                Text(
                                  interpretation,
                                  style: kBodyTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
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
                  label: 'RE-CALCULATE', onPress: () => Navigator.pop(context)),
            ),
          )
        ],
      ),
    );
  }
}
