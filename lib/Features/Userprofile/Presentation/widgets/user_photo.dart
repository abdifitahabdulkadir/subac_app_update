import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// my imports
import '/Features/Userprofile/Presentation/state/fetching_user_image_provider.dart';
import 'upload_profile_image.dart';

class UserPhoto extends ConsumerWidget {
  bool showCameraIcon = false;
  UserPhoto({required this.showCameraIcon});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
   
    return Stack(
      children: [
        Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: Consumer(
              builder: (_, WidgetRef ref, Widget? child) {
                final ggetUserData = ref.watch(fetchingUserProfileProvider);
                return ggetUserData.when(
                    data: (userData) {
                      return ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(userData["profile_url"] ?? ""),
                      );
                    },
                    error: (exceptionMessage, _) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(exceptionMessage.toString())));
                      return Text(exceptionMessage.toString());
                    },
                    loading: () => Container());
              },
            ),
          ),
        ),
        if (showCameraIcon)
          Positioned(
              left: 210,
              bottom: -10,
              child: TextButton(
                onPressed: () => uploadProfileImage(ref: ref),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.add_a_photo,
                    size: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ))
      ],
    );
  }
}
