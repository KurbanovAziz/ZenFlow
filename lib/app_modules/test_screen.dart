///Package imports
import 'package:flutter/cupertino.dart';

///calendar import
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:zen_flow/utils/app_imports/app_imports.dart';

class CircularTest extends StatefulWidget {
  const CircularTest({super.key});

  @override
  State<CircularTest> createState() => _CircularTestState();
}

class _CircularTestState extends State<CircularTest> {
  bool _enableDragging = true;
  double _value = 10;
  double _annotationFontSize = 20;
  String _annotationValue = '10';
  double _firstMarkerSize = 30;
  List<int> timeValues = [
    5,
    10,
    15,
    20,
    25,
    30,
    35,
    40,
    45,
    50,
    55,
    60,
    65,
    70,
    75,
    80,
  ];

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      _firstMarkerSize = 25;
      _annotationFontSize = 20;
    } else {
      // _firstMarkerSize = model.isWebFullView ? 35 : 15;
      // _annotationFontSize = model.isWebFullView ? 20 : 15;
    }

    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          timeBottomSheet(),
          isScrollControlled: true,
        );
      },
      child: Center(
        child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
                radiusFactor: 0.5,
                axisLineStyle: const AxisLineStyle(
                    color: Color.fromRGBO(191, 214, 245, 1),
                    // : const Color.fromRGBO(36, 58, 89, 1),
                    thickness: 0.075,
                    thicknessUnit: GaugeSizeUnit.factor),
                showLabels: false,
                showTicks: false,
                startAngle: 270,
                endAngle: 270,
                pointers: <GaugePointer>[
                  RangePointer(
                      width: 0.075,
                      value: _value,
                      cornerStyle: CornerStyle.bothCurve,
                      color: _enableDragging
                          ? AppColors.PRIMARY_COLOR
                          : AppColors.GRAY,
                      sizeUnit: GaugeSizeUnit.factor),
                  MarkerPointer(
                    value: _value,
                    onValueChanged: handlePointerValueChanged,
                    onValueChangeEnd: handlePointerValueChanged,
                    onValueChanging: handlePointerValueChanging,
                    elevation: 5,
                    enableDragging: _enableDragging,
                    color: _enableDragging
                        ? AppColors.PRIMARY_COLOR
                        : AppColors.GRAY,
                    markerHeight: _firstMarkerSize,
                    markerWidth: _firstMarkerSize,
                    markerType: MarkerType.circle,
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      widget: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            _annotationValue,
                            style: TextStyle(
                                fontSize: 50, color: AppColors.WHITE_COLOR

                                // fontFamily: 'Times',
                                // fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            'Minutes',
                            style: TextStyle(
                                fontSize: _annotationFontSize,
                                color: AppColors.WHITE_COLOR
                                // fontFamily: 'Times',
                                // fontWeight: FontWeight.bold,
                                ),
                          )
                        ],
                      ),
                      angle: 90)
                ])
          ],
        ),
      ),
    );
  }

  @override
  Widget buildSettings(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter stateSetter) {
      return Row(children: <Widget>[
        Text('Enable drag', style: TextStyle(color: AppColors.BLACK)),
        Padding(
          padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
          child: Transform.scale(
              scale: 0.8,
              child: CupertinoSwitch(
                activeColor: AppColors.WHITE_COLOR,
                value: _enableDragging,
                onChanged: (bool value) {
                  setState(() {
                    _enableDragging = value;
                    stateSetter(() {});
                  });
                },
              )),
        ),
      ]);
    });
  }

  /// Dragged pointer new value is updated to pointer and
  /// annotation current value.
  void handlePointerValueChanged(double value) {
    _setPointerValue(value);
  }

  /// Pointer dragging is canceled when dragging pointer value is less than 6.
  void handlePointerValueChanging(ValueChangingArgs args) {
    if ((args.value.toInt() - _value).abs() > 20) {
      args.cancel = true;
      if (_value > 50) {
        const double value = 100;
        _setPointerValue(value);
      }
    }
  }

  /// Method to set the pointer value
  void _setPointerValue(double value) {
    setState(() {
      _value = value;
      int roundedValue = value.round();
      if (timeValues.contains(roundedValue)) {
        _annotationValue = '$roundedValue';
      }
    });
  }

  timeBottomSheet() {
    return Container(
      height: Get.height,
      padding: AppPaddings.defaultPadding,
      decoration: BoxDecoration(
        color: AppColors.BLACK.withOpacity(0.9),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 7,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var index = 0; index < timeValues.length; index++) ...{
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _value = timeValues[index].toDouble();
                          _annotationValue = timeValues[index].toString();
                        });
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: AppBorderRadius.BORDER_RADIUS_10,
                            color:
                                _annotationValue == timeValues[index].toString()
                                    ? AppColors.PRIMARY_COLOR.withOpacity(0.2)
                                    : AppColors.WHITE_COLOR.withOpacity(0.2),
                          ),
                          padding: AppPaddings.defaultPadding,
                          child: Center(
                            child: AppText(
                              text: timeValues[index].toString() + " minutes",
                              color: _annotationValue ==
                                      timeValues[index].toString()
                                  ? AppColors.PRIMARY_COLOR
                                  : AppColors.WHITE_COLOR,
                            ),
                          ),
                        ),
                      ),
                    )
                  }
                ],
              ),
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 20.0),
          //     child: AppButton(
          //       buttonName: 'selectTime'.tr,
          //       buttonWidth: Get.width,
          //       buttonColor: AppColors.PRIMARY_COLOR,
          //       textColor: AppColors.WHITE_COLOR,
          //       onTap: () {
          //         Get.back();
          //       },
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}

// ///Package imports
// import 'package:flutter/cupertino.dart';

// ///calendar import
// import 'package:syncfusion_flutter_gauges/gauges.dart';
// import 'package:zen_flow/utils/app_imports/app_imports.dart';

// class CircularProgress extends StatefulWidget {
//   const CircularProgress({super.key});

//   @override
//   State<CircularProgress> createState() => _CircularProgressState();
// }

// class _CircularProgressState extends State<CircularProgress> {
//   bool _enableDragging = true;
//   double _value = 30;
//   double _annotationFontSize = 20;
//   String _annotationValue = '30';
//   double _firstMarkerSize = 30;

//   @override
//   Widget build(BuildContext context) {
//     if (MediaQuery.of(context).orientation == Orientation.portrait) {
//       _firstMarkerSize = 25;
//       _annotationFontSize = 20;
//     } else {
//       // _firstMarkerSize = model.isWebFullView ? 35 : 15;
//       // _annotationFontSize = model.isWebFullView ? 20 : 15;
//     }

//     return Center(
//       child: SfRadialGauge(
//         axes: <RadialAxis>[
//           RadialAxis(
//               radiusFactor: 0.8,
//               axisLineStyle: AxisLineStyle(
//                   color: const Color.fromRGBO(191, 214, 245, 1),
//                   // : const Color.fromRGBO(36, 58, 89, 1),
//                   thickness: 0.075,
//                   thicknessUnit: GaugeSizeUnit.factor),
//               showLabels: false,
//               showTicks: false,
//               startAngle: 270,
//               endAngle: 270,
//               pointers: <GaugePointer>[
//                 RangePointer(
//                     width: 0.075,
//                     value: _value,
//                     cornerStyle: CornerStyle.bothCurve,
//                     color: _enableDragging
//                         ? const Color.fromRGBO(44, 117, 220, 1)
//                         : const Color(0xFF888888),
//                     sizeUnit: GaugeSizeUnit.factor),
//                 MarkerPointer(
//                   value: _value,
//                   onValueChanged: handlePointerValueChanged,
//                   onValueChangeEnd: handlePointerValueChanged,
//                   onValueChanging: handlePointerValueChanging,
//                   elevation: 5,
//                   enableDragging: _enableDragging,
//                   color: _enableDragging
//                       ? const Color.fromRGBO(44, 117, 220, 1)
//                       : const Color(0xFF888888),
//                   markerHeight: _firstMarkerSize,
//                   markerWidth: _firstMarkerSize,
//                   markerType: MarkerType.circle,
//                 )
//               ],
//               annotations: <GaugeAnnotation>[
//                 GaugeAnnotation(
//                     widget: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         Text(
//                           _annotationValue,
//                           style: TextStyle(
//                             fontSize: _annotationFontSize,
//                             // fontFamily: 'Times',
//                             // fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           '%',
//                           style: TextStyle(
//                             fontSize: _annotationFontSize,
//                             // fontFamily: 'Times',
//                             // fontWeight: FontWeight.bold,
//                           ),
//                         )
//                       ],
//                     ),
//                     angle: 90)
//               ])
//         ],
//       ),
//     );
//   }

//   @override
//   Widget buildSettings(BuildContext context) {
//     return StatefulBuilder(
//         builder: (BuildContext context, StateSetter stateSetter) {
//       return Row(children: <Widget>[
//         Text('Enable drag', style: TextStyle(color: AppColors.BLACK)),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
//           child: Transform.scale(
//               scale: 0.8,
//               child: CupertinoSwitch(
//                 activeColor: AppColors.WHITE_COLOR,
//                 value: _enableDragging,
//                 onChanged: (bool value) {
//                   setState(() {
//                     _enableDragging = value;
//                     stateSetter(() {});
//                   });
//                 },
//               )),
//         ),
//       ]);
//     });
//   }

//   /// Dragged pointer new value is updated to pointer and
//   /// annotation current value.
//   void handlePointerValueChanged(double value) {
//     _setPointerValue(value);
//   }

//   /// Pointer dragging is canceled when dragging pointer value is less than 6.
//   void handlePointerValueChanging(ValueChangingArgs args) {
//     if ((args.value.toInt() - _value).abs() > 20) {
//       args.cancel = true;
//       if (_value > 50) {
//         const double value = 100;
//         _setPointerValue(value);
//       }
//     }
//   }

//   /// Method to set the pointer value
//   void _setPointerValue(double value) {
//     setState(() {
//       _value = value;
//       // ignore: no_leading_underscores_for_local_identifiers
//       int _currentValue = _value.toInt();
//       _currentValue = _currentValue >= 100 ? 100 : _currentValue;
//       _annotationValue = '$_currentValue';
//     });
//   }
// }
