import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/complete_assembly.dart';

final completeAssemblyProvider =
    StateProvider.autoDispose<Widget>((ref) => CompleteAssembly());
