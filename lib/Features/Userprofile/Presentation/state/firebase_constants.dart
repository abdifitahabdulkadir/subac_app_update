import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// my imports
import '/Features/Userprofile/Presentation/widgets/user_profile.dart';

/*
* retuns the firebase Auth instance to use inside the my feature
*/
final firebaseAuthInstanceProvider = Provider((ref) => FirebaseAuth.instance);

/*
* retuns the firebase instance to use inside the my feature
*/
final firebaseFirebaseInstanceProvider =
    Provider((ref) => FirebaseFirestore.instance);

/*
* provider that returns make globally avaliable for the userProfile widget
*/
final userProfileProvider = Provider<Widget>((ref) => UserProfile());
