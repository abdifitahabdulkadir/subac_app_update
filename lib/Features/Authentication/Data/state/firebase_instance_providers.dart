import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
* globally avalibale instace of firebase auth to all layers in the data layer.
*/
final firebasAuthInstance = FirebaseAuth.instance;

/*
* globally avalibale instace of firebase cloud firestore to all layers in the data layer.
*/
final firestoreInstace = FirebaseFirestore.instance;
