import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialGauge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
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
                value: 80,
                enableAnimation: true,
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Text(
                  "80% Completed",
                  style: Theme.of(context).textTheme.bodySmall,
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
