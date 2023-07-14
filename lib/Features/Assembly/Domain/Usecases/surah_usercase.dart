import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Authentication/core/Erros/auth_error_handling.dart';

abstract class SurahUserCase {
  Future<void> fetchSurahInformaitonUserCase({required WidgetRef ref});
}
