import 'dart:developer';

import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/widgets/box_helper.dart';
import 'package:creen/core/utils/widgets/register_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/utils/routing/navigation_service.dart';
import '../../ads/view/widgets/ads_item.dart';
import '../viewModel/bmiCalc/bmi_calc_cubit.dart';
// import 'package:time_chart/time_chart.dart';

class BMICalcScreen extends StatefulWidget {
  const BMICalcScreen({Key? key}) : super(key: key);

  @override
  State<BMICalcScreen> createState() => _BMICalcScreenState();
}

class _BMICalcScreenState extends State<BMICalcScreen>
    with SingleTickerProviderStateMixin {
  late BmiCalcCubit bmiCalcCubit;
  // List<DateTimeRange> data = [
  //   DateTimeRange(
  //     start: DateTime(2021, 2, 24, 23, 15),
  //     end: DateTime(2021, 2, 25, 7, 30),
  //   ),
  //   DateTimeRange(
  //     start: DateTime(2021, 2, 22, 1, 55),
  //     end: DateTime(2021, 2, 22, 9, 12),
  //   ),
  //   DateTimeRange(
  //     start: DateTime(2021, 2, 20, 0, 25),
  //     end: DateTime(2021, 2, 20, 7, 34),
  //   ),
  //   DateTimeRange(
  //     start: DateTime(2021, 2, 17, 21, 23),
  //     end: DateTime(2021, 2, 18, 4, 52),
  //   ),
  //   DateTimeRange(
  //     start: DateTime(2021, 2, 13, 6, 32),
  //     end: DateTime(2021, 2, 13, 13, 12),
  //   ),
  //   DateTimeRange(
  //     start: DateTime(2021, 2, 1, 9, 32),
  //     end: DateTime(2021, 2, 1, 15, 22),
  //   ),
  //   DateTimeRange(
  //     start: DateTime(2021, 1, 22, 12, 10),
  //     end: DateTime(2021, 1, 22, 16, 20),
  //   ),
  // ];
  late TabController tabController;

  @override
  void initState() {
    bmiCalcCubit = context.read<BmiCalcCubit>()..getSteps();
    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 1,
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(bmiCalcCubit.status, name: 'status_calc');
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       NavigationService.push(
        //         page: const GoalsScreen(),
        //       );
        //     },
        //     child: const Icon(
        //       Icons.settings,
        //       color: Colors.white,
        //     ),
        //   ),
        // ],
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            NavigationService.goBack();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          color: Colors.white,
        ),
        bottom: TabBar(
          tabs: [
            'day',
            'week',
            'month',
          ]
              .map(
                (e) => Text(e),
              )
              .toList(),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          controller: tabController,
          indicator: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<BmiCalcCubit, BmiCalcState>(
          builder: (context, state) {
            log('$state', name: 'state_bmi');
            var differenceAsTime = bmiCalcCubit.getDifferentBetweenTimes();
            return SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      const WalkingCircularIndicator(),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomizedCircleWidget(
                              icons: Icons.water_drop,
                              title:
                                  '${bmiCalcCubit.calories.toStringAsFixed(2)} ${'cal'.translate}', perc: (bmiCalcCubit.calories/2),
                            ),
                            CustomizedCircleWidget(
                              icons: Icons.arrow_forward,
                              title:
                                  '${bmiCalcCubit.miles.toStringAsFixed(2)} ${'mi'.translate}', perc: (bmiCalcCubit.miles/2),
                            ),
                            CustomizedCircleWidget(
                              icons: Icons.timer,
                              title:
                                  '${differenceAsTime.hour}:${differenceAsTime.minute} ${'h'.translate}', perc: (differenceAsTime.minute/6),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
                      ),
                    ],
                  ),
                  BoxHelper(
                      height: 120,
                      // width: 100,
                      child: SfCartesianChart(
                          // Initialize category axis
                          primaryXAxis: CategoryAxis(opposedPosition: true),
                          series: <ChartSeries<SalesData, String>>[
                            StackedLineSeries<SalesData, String>(
                                markerSettings:
                                    const MarkerSettings(isVisible: true),
                                // Bind data source
                                dataSource: bmiCalcCubit.totalSteps
                                    .map(
                                      (e) => SalesData(
                                        DateFormat.EEEE()
                                            .format(
                                                e.createdAt ?? DateTime.now())
                                            .toString(),
                                        e.currentSteps?.toDouble() ?? 0.0,
                                      ),
                                    )
                                    .toList(),
                                xValueMapper: (SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (SalesData sales, _) =>
                                    sales.sales)
                          ])),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomizedCircleWidget extends StatelessWidget {
  const CustomizedCircleWidget({
    Key? key,
    required this.icons,
    required this.title,
    required this.perc,
  }) : super(key: key);
  final IconData icons;
  final String title;
  final double perc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: ScreenUtil().radius(30),
          lineWidth: 5.0,
          percent: perc,
          center: Icon(
            icons,
            color: Colors.white,
            size: ScreenUtil().radius(30),
          ),
          progressColor: Colors.green,
        ),
        SizedBox(
          height: ScreenUtil().setHeight(2),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(16),
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class WalkingCircularIndicator extends StatelessWidget {
  const WalkingCircularIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiCalcCubit, BmiCalcState>(
      builder: (context, state) {
        var bmi = context.read<BmiCalcCubit>();
        var stepsInPercentage = bmi.stepsInPercentage;
        log('step $stepsInPercentage');
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularPercentIndicator(
            radius: ScreenUtil().radius(150),
            lineWidth: 5.0,
            percent: stepsInPercentage,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                      if (kDebugMode) {
                        print("_steps ${30000}");
                        print("bmi ${bmi.hasStarted}");
                      }
                    if (bmi.hasStarted) {

                      bmi.createOrUpdateSteps();
                      return;
                    }
                    showDialog(
                      context: context,
                      builder: (_) => BlocProvider.value(
                        value: bmi,
                        child: const StartDialog(),
                      ),
                    );
                  },
                  // onTap: bmi.changeStartStatus,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.run_circle,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(14),
                      ),
                      Text(
                        (bmi.hasStarted ? 'stop' : 'start').translate,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  bmi.steps.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(90),
                  ),
                ),
                const BoxHelper(
                  height: 10,
                ),
                Text(
                  '${'today'.translate} \n${'goal'.translate} ${bmi.todaySteps?.goal?.toString() ?? '0'}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(16),
                    color: Colors.white54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  bmi.remainingSteps.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(16),
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            progressColor: Colors.green,
          ),
        );
      },
    );
  }
}

class StartDialog extends StatelessWidget {
  const StartDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var bmi = context.read<BmiCalcCubit>();
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Form(
          key: bmi.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AdsItem(
                text: '',
                hintText: 'steps_number_add'.translate,
                isMessage: false,

                keyboardType: TextInputType.phone,
                onChanged: (v) {},
                controller: bmi.goalController,
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'goal_required'.translate;
                  }
                  return null;
                },
                // hintText: 'blog_description',
              ),
              RegisterButton(
                title: 'start',
                removeBorderColor: true,
                color: Colors.green,
                onPressed: () {
                  bmi.changeStartStatus();
                  NavigationService.goBack();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
