import "package:flutter_riverpod/flutter_riverpod.dart";

/*
* this is the provider that retuns true to show user login as first page
*/
final showLoginProvider = StateProvider<bool>((ref) => true);

/*
* this is the provider to show loading and by defualt is false
*/
final isloadingProvider = StateProvider<bool>((ref) => false);
