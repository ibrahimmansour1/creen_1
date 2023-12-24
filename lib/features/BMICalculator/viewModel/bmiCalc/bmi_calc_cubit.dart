import 'dart:async';
import 'dart:developer';

import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/features/BMICalculator/repo/create_steps_repo.dart';
import 'package:creen/features/BMICalculator/repo/steps_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../model/step_data.dart';

part 'bmi_calc_state.dart';

class BmiCalcCubit extends Cubit<BmiCalcState> {
  BmiCalcCubit() : super(BmiCalcInitial()) {
    // initPlatformState();
  }
  StreamSubscription<StepCount>? _stepCountStream;
  // StreamSubscription<PedestrianStatus>? _pedestrianStatusStream;
bool once = true;
  int _steps = 0;
  int _initialSteps = 0;
  var _hasStarted = false;
  var goalController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  List<StepData>? _totalSteps = [];
  StepData? _todayStep;
  int get steps => _steps;
  double get calories => (_steps-_initialSteps) /23.8;
  double get miles => (_steps-_initialSteps) *0.0008;
  List<StepData> get totalSteps => [...?_totalSteps];
  StepData? get todaySteps => _todayStep;
  DateTime? stepTimeStamps;
  bool get hasStarted => _hasStarted;

  double get stepsInPercentage {
    var goal = _todayStep?.goal ?? 0;
    log('$goal $_steps', name: 'stepsInPercentage');
    if (_steps == 0) {
      return 0;
    }
    var percentage = (  (_steps-_initialSteps)/goal);
if(percentage > 1.0) {
  percentage =1;
}
    return percentage;
  }

  int get remainingSteps {
    var remaining = 0;
    remaining = (_todayStep?.goal ?? 0) - (_steps-_initialSteps);
    if (remaining < 0) {
      return 0;
    }
    return remaining;
  }

  void onStepCount(StepCount event) {
    /// Handle step count changed
    if(once){
_initialSteps = event.steps;
once = false;
    }
    _steps = event.steps;
    Fluttertoast.showToast(msg: 'steps ${event.steps} time${event.timeStamp}');

    stepTimeStamps ??= event.timeStamp;
    if (kDebugMode) {
      print("event steps ${steps - _initialSteps}");

      print("event time ${event.timeStamp}");
    }
    emit(StepStateChanged(
      steps: steps-_initialSteps,
      timeStamp: event.timeStamp,
    ));
  }

  TimeOfDay getDifferentBetweenTimes() {
    Duration difference = DateTime.now().difference(
      stepTimeStamps ?? DateTime.now(),
    );
    int differenceInSeconds = difference.inSeconds;
    TimeOfDay differenceAsTimeOfDay = TimeOfDay(
      hour: (differenceInSeconds / 3600).floor(),
      minute: ((differenceInSeconds % 3600) / 60).floor(),
    );
    return differenceAsTimeOfDay;
  }

  final String _status = 'none';
  String get status => _status;
  DateTime? timeStamp;

  // void onPedestrianStatusChanged(PedestrianStatus event) {
  //   /// Handle status changed
  //   _status = event.status;
  //   timeStamp = event.timeStamp;
  //   var message = 'status ${event.status} time${event.timeStamp}';
  //   log(message, name: 'statys');

  //   Fluttertoast.showToast(msg: message);
  //   emit(StatusStateChanged(
  //     status: event.status,
  //     timeStamp: event.timeStamp,
  //   ));
  // }

  void onPedestrianStatusError(error) {
    /// Handle the
    log('$error', name: 'onPedestrianStatusError');
    Fluttertoast.showToast(msg: '$error', backgroundColor: Colors.red);
  }

  void onStepCountError(error) {
    log('$error', name: 'onStepCountError');
    Fluttertoast.showToast(msg: '$error', backgroundColor: Colors.red);

    /// Handle the error
  }

  void initPlatformState() async {
    var isGranted = await Permission.activityRecognition.request().isGranted;
    if (!isGranted) {
      return;
    }

    /// Init streams
    log('message init');
    Fluttertoast.showToast(msg: 'msg');
    // _pedestrianStatusStream = Pedometer.pedestrianStatusStream
    //     .listen(onPedestrianStatusChanged)
    // ..onError(onPedestrianStatus`Error);
    _stepCountStream = Pedometer.stepCountStream.listen(onStepCount)
      ..onError(onStepCountError);

    /// Listen to streams and handle errors
  }

  Future<void> getSteps() async {
    emit(BmiCalcLoading());

    try {
      var stepsData = await StepsRepo.getSteps();
      if (stepsData == null) {
        return;
      }
      if (stepsData.status == true) {
        _totalSteps = stepsData.data?.totalSteps;
        _todayStep = stepsData.data?.todaySteps;
      }
      emit(BmiCalcDone());
    } catch (_) {
      Fluttertoast.showToast(
        msg: 'something_wrong'.translate,
        backgroundColor: Colors.red,
      );
      emit(BmiCalcError());
    }
  }

  Future<void> createOrUpdateSteps() async {
    emit(CreateBmiCalcLoading());

    try {
      var isEdit = _todayStep != null &&
          DateTime.now()
                  .difference(_todayStep?.createdAt ?? DateTime.now())
                  .inDays ==
              0;
      var differenceAsTime = getDifferentBetweenTimes();
      log('${_todayStep?.id} $_todayStep');
      if (isEdit) {
        _toggleStartButton();
      }
      if (kDebugMode) {
        print("_steps $_steps");

        print("calories $calories");
        print("goalController.text ${goalController.text}");
        print("houres ${differenceAsTime.hour}");
        print("minutes ${differenceAsTime.minute}");
        print("_todayStep?.id ${_todayStep?.id}");
      }
      var createStepsData = await CreateStepsRepo.createSteps(
        isEdit: isEdit,
        body: {
          'currentSteps': _steps,
          'calaroies': calories.toStringAsFixed(2),
          if (goalController.text.isNotEmpty) ...{
            'goal': goalController.text,
          },
          'houres': differenceAsTime.hour,
          'minutes': differenceAsTime.minute,
          if (isEdit) ...{
            'step_id': _todayStep?.id,
          }
/**
 'currentSteps'      => 'nullable',
               'goal'              => 'nullable',
               'calaroies'         => 'nullable',
               'houres'            => 'nullable',
               'minutes'           => 'nullable',
 */
        },
      );
      if (createStepsData == null) {
        return;
      }
      if (createStepsData.status == true) {
        _todayStep = createStepsData.data;
        var index = _totalSteps
                ?.indexWhere((element) => element.id == _todayStep?.id) ??
            -1;
        if (index >= 0) {
          _totalSteps?[index] = createStepsData.data!;
        } else {
          _totalSteps?.insert(0, createStepsData.data!);
        }
        _killStreams();
        stepTimeStamps = null;
      }
      emit(BmiCalcDone( ));
    } catch (_) {
      Fluttertoast.showToast(
        msg: 'something_wrong'.translate,
        backgroundColor: Colors.red,
      );
      emit(BmiCalcError());
    }
  }

  // @override
  // Future<void> close() {
  //   _killStreams();
  //   goalController.dispose();
  //   return super.close();
  // }

  void _killStreams() {
    // _pedestrianStatusStream?.cancel();
    _stepCountStream?.pause();
    // _pedestrianStatusStream = null;
    _stepCountStream = null;
  }

  void changeStartStatus() {
   if(_stepCountStream !=null)
    {if (_stepCountStream!.isPaused) {
      _stepCountStream?.resume();
    }}
    if (!_hasStarted) {
      var validate = formKey.currentState?.validate() ?? false;
      if (!validate) {
        return;
      }
      stepTimeStamps = DateTime.now();
      initPlatformState();
    } else {
      createOrUpdateSteps();
      _killStreams();
    }
   _toggleStartButton();
  }

  void _toggleStartButton() {

    _hasStarted = !hasStarted;
    emit(StartStateChanged(hasStarted: _hasStarted));
  }
}
