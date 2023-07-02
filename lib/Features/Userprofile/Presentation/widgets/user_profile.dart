import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// my imports
import '/Features/Userprofile/Presentation/state/firebase_constants.dart';
import '/Features/Userprofile/Presentation/widgets/buildListTile.dart';
import '/Features/Userprofile/Presentation/widgets/user_photo.dart';

class UserProfile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            SizedBox(height: 30),
            UserPhoto(),
            Text("Mr IT"),
            const SizedBox(height: 35),
            SizedBox(
              height: 600,
              width: 620,
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: BuildListTilie(
                          title: "Edit Profile", leadingIcon: Icons.person),
                    ),
                    BuildListTilie(
                        title: "Setting", leadingIcon: Icons.settings),
                    GestureDetector(
                      onTap: () {},
                      child: BuildListTilie(
                          title: "Invite Freinds",
                          leadingIcon: Icons.person_add),
                    ),
                    Divider(height: 3, color: Colors.grey.withOpacity(0.5)),
                    BuildListTilie(title: "Help", leadingIcon: Icons.help),
                    GestureDetector(
                      onTap: () async => await ref
                          .watch(firebaseAuthInstanceProvider)
                          .signOut(),
                      child: BuildListTilie(
                        title: "Logout",
                        leadingIcon: Icons.login_outlined,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
