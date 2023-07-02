import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// my imports
import 'firebase_constants.dart';

final fetchingUserProfileProvider = FutureProvider<Widget>((ref) async {
  final _imageUrl = await ref
      .watch(firebaseFirebaseInstanceProvider)
      .collection("userinformation")
      .where("userid",
          isEqualTo: ref.watch(firebaseAuthInstanceProvider).currentUser!.uid)
      .get()
      .then((snapshotMode) => snapshotMode.docs[0].data()["profile_url"]);
  return Image.network(_imageUrl);
});
