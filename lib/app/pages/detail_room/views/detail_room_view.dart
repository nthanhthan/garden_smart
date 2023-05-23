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
    Get.offNamed(Routes.control, arguments: controller.index);
  }

  Widget _mainBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        backgroundColor: AppColors.main.shade300,
        iconTheme: const IconThemeData(color: AppColors.white),
        centerTitle: true,
        title: Text(
          controller.room ?? "",
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
                  Obx(
                    () => Expanded(
                      child: _percentWidget(
                        context,
                        AppColors.secondary.shade300,
                        "Air Humidity",
                        controller.controlModelResp.hum ?? 0,
                        AppColors.grey.shade300,
                      ),
                    ),
                  ),
                  Obx(
                    () => Expanded(
                      child: _percentWidget(
                        context,
                        AppColors.lightPurple,
                        "Soil moisture",
                        controller.controlModelResp.doamdat ?? 0,
                        AppColors.grey.shade300,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(
                () => _percentWidget(
                  context,
                  AppColors.success,
                  "Rain moisture",
                  controller.controlModelResp.rain ?? 0,
                  AppColors.grey.shade300,
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -80),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Obx(
                        () => _getRadialGauge(
                          S.of(Get.context!).temperature,
                          controller.controlModelResp.temp ?? 0,
                          50,
                        ),
                      ),
                    ),
                    Obx(
                      () => Expanded(
                        child: _getRadialGauge(
                          "Light",
                          controller.controlModelResp.light ?? 0,
                          80,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -70),
                child: Obx(
                  () => _phWidget(controller.controlModelResp.ph ?? 0),
                ),
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
        animationDuration: 2000,
        enableLoadingAnimation: true,
        title: GaugeTitle(
          text: "",
          textStyle: AppTextStyles.subHeading1(),
        ),
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 100,
            ranges: <GaugeRange>[
              GaugeRange(
                  startValue: 0,
                  endValue: 30,
                  color: Colors.green,
                  startWidth: 10,
                  endWidth: 10),
              GaugeRange(
                  startValue: 30,
                  endValue: 70,
                  color: Colors.orange,
                  startWidth: 10,
                  endWidth: 10),
              GaugeRange(
                  startValue: 70,
                  endValue: 100,
                  color: Colors.red,
                  startWidth: 10,
                  endWidth: 10)
            ],
            pointers: <GaugePointer>[NeedlePointer(value: value)],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Text(
                  value.toStringAsFixed(1),
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

  Widget _phWidget(double value) {
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
            markerPointers: [
              LinearShapePointer(
                value: value,
                width: 20,
                height: 20,
                shapeType: LinearShapePointerType.invertedTriangle,
                color: AppColors.main,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "PH = $value",
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
