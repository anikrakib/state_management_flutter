import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weight_calculator/component/bottom_button.dart';
import 'package:weight_calculator/component/reusable_card.dart';
import 'package:weight_calculator/constants.dart';
import 'package:weight_calculator/provider_state_management/provider/weight_calculator.dart';
import '../../../calculation.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<WeightCalculator>(context);
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    var calculation =
        Calculation(height: providerData.height, weight: providerData.weight);

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
                                calculation.getResult(),
                                style: kResultsTextStyle,
                              ),
                              Text(
                                calculation.calculate(),
                                style: kAppBarTitleTextStyle,
                              ),
                              Text(
                                calculation.getInterpretation(),
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