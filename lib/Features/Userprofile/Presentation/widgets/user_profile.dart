import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// my imports
import '../../../../core/state/firebase_constants.dart';
import '/Features/Userprofile/Presentation/widgets/buildListTile.dart';
import '/Features/Userprofile/Presentation/widgets/user_photo.dart';
import '/Features/Userprofile/Presentation/screens/setting.dart';
import '/Features/Userprofile/Presentation/screens/edit_profile_informatioin.dart';
import '/Features/Userprofile/Presentation/state/fetching_user_image_provider.dart';

class UserProfile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            SizedBox(height: 30),
            UserPhoto(showCameraIcon: false),
            Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? chidl) {
              return ref.watch(fetchingUserProfileProvider).when(data: (data) {
                return Text(
                  data["name"] ?? "",
                  style: Theme.of(context).textTheme.bodySmall,
                );
              }, loading: () {
                return CircularProgressIndicator(
                  color: Colors.black,
                );
              }, error: (message, _) {
                return Text(message.toString());
              });
            }),
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
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(EditProfileInformation.routeName);
                      },
                      child: BuildListTilie(
                          title: "Edit Profile", leadingIcon: Icons.person),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.of(context).pushNamed(Setting.routeName),
                      child: BuildListTilie(
                          title: "Setting", leadingIcon: Icons.settings),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Share.share("www.subac-app.com",
                            subject: "Subac Application",
                            sharePositionOrigin: Rect.fromCenter(
                              center: Offset.zero,
                              width: 100,
                              height: 100,
                            ));
                      },
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
