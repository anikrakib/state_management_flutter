import 'dart:async';
import 'package:weight_calculator/calculation.dart';
import '../../constants.dart';

enum EventAction {
  ageIncrement,
  ageDecrement,
  weightIncrement,
  weightDecrement,
}

class WeightCalculatorBloc {
  int _height = 180;
  int _weight = 60;
  int _age = 20;
  Sex _gender = Sex.male;

  final _stateAgeStreamController = StreamController<int>();
  StreamSink<int> get _ageSink => _stateAgeStreamController.sink;
  Stream<int> get ageStream => _stateAgeStreamController.stream;

  final _stateHeightStreamController = StreamController<int>.broadcast();
  StreamSink<int> get _heightSink => _stateHeightStreamController.sink;
  Stream<int> get heightStream => _stateHeightStreamController.stream;

  final _stateWeightStreamController = StreamController<int>.broadcast();
  StreamSink<int> get _weightSink => _stateWeightStreamController.sink;
  Stream<int> get weightStream => _stateWeightStreamController.stream;

  final _stateGenderStreamController = StreamController<Sex>();
  StreamSink<Sex> get _genderSink => _stateGenderStreamController.sink;
  Stream<Sex> get genderStream => _stateGenderStreamController.stream;

  final _eventStreamController = StreamController<EventAction>();
  StreamSink<EventAction> get eventSink => _eventStreamController.sink;
  Stream<EventAction> get eventStream => _eventStreamController.stream;

  int newHeight = 180;
  int newWeight = 60;

  WeightCalculatorBloc() {
    eventStream.listen((event) {
      switch (event) {
        case EventAction.ageDecrement:
          _age--;
          _ageSink.add(_age);
          break;
        case EventAction.ageIncrement:
          _age++;
          _ageSink.add(_age);
          break;
        case EventAction.weightIncrement:
          _weight++;
          _weightSink.add(_weight);
          break;
        case EventAction.weightDecrement:
          _weight--;
          _weightSink.add(_weight);
          break;
      }
    });
    _stateHeightStreamController.stream.listen((value) {
      newHeight = value;
    });
    _stateWeightStreamController.stream.listen((value) {
      newWeight = value;
    });
  }

  void changeHeight(int height) {
    _height = height;
    _heightSink.add(_height);
  }

  Calculation calculation() {
    var cal = Calculation(height: newHeight, weight: newWeight);
    return cal;
  }

  void changeGender(Sex gender) {
    _gender = gender;
    _genderSink.add(_gender);
  }

  void dispose() {
    _stateAgeStreamController.close();
    _stateGenderStreamController.close();
    _stateHeightStreamController.close();
    _stateWeightStreamController.close();
    _eventStreamController.close();
  }
}
