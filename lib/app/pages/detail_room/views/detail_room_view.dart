import 'package:action_slider/action_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetailRoomView extends GetView<DetailRoomController> {
  const DetailRoomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _mainBody(context);
  }

  void _controlClick() {
    Get.offNamed(Routes.control);
  }

  Widget _mainBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        backgroundColor: AppColors.main.shade300,
        iconTheme: const IconThemeData(color: AppColors.white),
        centerTitle: true,
        title: const Text(
          "Room 1",
        ),
      ),
      bottomNavigationBar: _sliderWidget(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _percentWidget(
                      context,
                      AppColors.secondary.shade300,
                      "Air Humidity",
                      0.6,
                      AppColors.grey.shade300,
                    ),
                  ),
                  Expanded(
                    child: _percentWidget(
                      context,
                      AppColors.lightPurple,
                      "Soil moisture",
                      0.3,
                      AppColors.grey.shade300,
                    ),
                  ),
                ],
              ),
              Transform.translate(
                offset: const Offset(0, -60),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _getRadialGauge(
                        S.of(Get.context!).temperature,
                        60,
                        50,
                      ),
                    ),
                    Expanded(
                      child: _getRadialGauge(
                        "Light",
                        40,
                        80,
                      ),
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -70),
                child: _phWidget(),
              ),
              // _sliderWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getRadialGauge(String type, double value, double left) {
    return Stack(children: [
      SfRadialGauge(
        animationDuration: 3000,
        title: GaugeTitle(
          text: "",
          textStyle: AppTextStyles.subHeading1(),
        ),
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 150,
            ranges: <GaugeRange>[
              GaugeRange(
                  startValue: 0,
                  endValue: 50,
                  color: Colors.green,
                  startWidth: 10,
                  endWidth: 10),
              GaugeRange(
                  startValue: 50,
                  endValue: 100,
                  color: Colors.orange,
                  startWidth: 10,
                  endWidth: 10),
              GaugeRange(
                  startValue: 100,
                  endValue: 150,
                  color: Colors.red,
                  startWidth: 10,
                  endWidth: 10)
            ],
            pointers: <GaugePointer>[NeedlePointer(value: value)],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Text(
                  value.toString(),
                  style: AppTextStyles.heading1(),
                ),
                angle: 90,
                positionFactor: 0.5,
              )
            ],
          )
        ],
      ),
      Positioned(
        bottom: 50,
        left: left,
        child: Text(
          type,
          style: AppTextStyles.body1(),
        ),
      )
    ]);
  }

  Widget _percentWidget(BuildContext context, Color color, String type,
      double value, Color bgColor) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 80.0,
          lineWidth: 20.0,
          animation: true,
          percent: value,
          animationDuration: 1500,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (value * 100).toString() + "%",
                style: AppTextStyles.heading1()
                    .copyWith(color: AppColors.main.shade300),
              ),
            ],
          ),
          backgroundColor: bgColor,
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: color,
        ),
        const SizedBox(height: 20),
        Text(
          type,
          style: AppTextStyles.body1(),
        ),
      ],
    );
  }

  Widget _phWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SfLinearGauge(
            minimum: 0,
            maximum: 14,
            showLabels: true,
            showTicks: true,
            animationDuration: 4000,
            majorTickStyle: const LinearTickStyle(length: 15),
            minorTickStyle: const LinearTickStyle(length: 10),
            ranges: const [
              LinearGaugeRange(
                startValue: 0,
                endValue: 7,
                color: Colors.red,
              ),
              LinearGaugeRange(
                startValue: 7,
                endValue: 14,
                color: Colors.green,
              ),
            ],
            markerPointers: const [
              LinearShapePointer(
                value: 8,
                width: 20,
                height: 20,
                shapeType: LinearShapePointerType.invertedTriangle,
                color: AppColors.main,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "PH = 8",
            style: AppTextStyles.body1(),
          ),
        ],
      ),
    );
  }

  Widget _sliderWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
      child: ActionSlider.custom(
        sliderBehavior: SliderBehavior.stretch,
        width: 320.0,
        height: 56.0,
        toggleWidth: 65.0,
        toggleMargin: EdgeInsets.zero,
        backgroundColor: AppColors.main.shade200,
        foregroundChild: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.main.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SvgPicture.asset(
              AssetsConst.next,
              height: 20,
              color: AppColors.white,
            ),
          ),
        ),
        foregroundBuilder: (context, state, child) => child!,
        outerBackgroundBuilder: (context, state, child) => Card(
          margin: EdgeInsets.zero,
          color: Color.lerp(
            AppColors.main.shade400,
            AppColors.main.shade200,
            state.position,
          ),
          child: Center(
            child: Text(
              S.of(context).control,
              style: AppTextStyles.body1().copyWith(
                color: AppColors.main.shade200,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        backgroundBorderRadius: BorderRadius.circular(16.0),
        action: (controller) async {
          controller.loading();
          controller.success();
          _controlClick();
        },
      ),
    );
  }
}
