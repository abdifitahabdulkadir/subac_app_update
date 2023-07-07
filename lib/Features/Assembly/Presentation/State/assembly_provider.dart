import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// imports
import '../widgets/assembly.dart';

final assemblyProvider = StateProvider<Widget>((ref) => Assembly());
