import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Screens/complete_assembly.dart';

final completeAssemblyProvider =
    StateProvider<Widget>((ref) => CompleteAssembly());
