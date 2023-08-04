import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Applicaton/Usecase/fetch_needle_data_usecase_imple.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialGauge extends ConsumerStatefulWidget {
  @override
  ConsumerState<RadialGauge> createState() => _RadialGaugeState();
}

class _RadialGaugeState extends ConsumerState<RadialGauge> {
  FetchNeedleDataUsecaseImple _dataUsecaseImple = FetchNeedleDataUsecaseImple();

  double _getPercentageValue = 0;

  void _calcuatePercentage(WidgetRef ref) async {
    await _dataUsecaseImple.fetchRadialNeedleData(ref: ref).then((value) {
      setState(() {
        _getPercentageValue = value.incompleteDraftValue;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _calcuatePercentage(ref);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: SfRadialGauge(
        enableLoadingAnimation: true,
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 100,
            interval: 10,
            ranges: <GaugeRange>[
              GaugeRange(
                startValue: 0,
                endValue: 30,
                color: Colors.red.shade700,
              ),
              GaugeRange(
                startValue: 30,
                endValue: 60,
                color: Colors.orange.shade700,
              ),
              GaugeRange(
                startValue: 60,
                endValue: 100,
                color: Colors.green.shade700,
              )
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                needleColor: Colors.green.shade600,
                value: _getPercentageValue,
                enableAnimation: true,
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: FittedBox(
                  child: Text(
                    "${_getPercentageValue}% Completed",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14,
                        ),
                  ),
                ),
                positionFactor: 0.79,
                angle: 90,
              )
            ],
          )
        ],
      ),
    );
  }
}
