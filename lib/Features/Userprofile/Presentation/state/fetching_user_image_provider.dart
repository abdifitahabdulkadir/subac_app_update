
import 'package:flutter_riverpod/flutter_riverpod.dart';

// my imports
import '../../../../core/state/firebase_constants.dart';

final fetchingUserProfileProvider =
    FutureProvider<Map<String, String>>((ref) async {
  String username = "";
  String imageUrl = "";
  await ref
      .watch(firebaseFirebaseInstanceProvider)
      .collection("userinformation")
      .where("userid",
          isEqualTo: ref.watch(firebaseAuthInstanceProvider).currentUser!.uid)
      .get()
      .then(
    (snapshoot) {
      username = snapshoot.docs[0].data()["name"];
      imageUrl = snapshoot.docs[0].data()["profile_url"];
    },
  );

  return {"name": username, "profile_url": imageUrl};
});
