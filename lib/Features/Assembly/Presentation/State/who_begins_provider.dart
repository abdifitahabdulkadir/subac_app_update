import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
* by default the user will start the quran reading by 
* you can simpy tweek by toggling the switch button
*/
final whoBeginsQuranReading = StateProvider.autoDispose<int>((ref) => 0);
