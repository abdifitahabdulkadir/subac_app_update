import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/radial_gauge.dart';

final radialProvider = StateProvider<Widget>((ref) => RadialGauge());
