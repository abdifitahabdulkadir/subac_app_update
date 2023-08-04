import 'package:cloud_firestore/cloud_firestore.dart';

class FetchDraftedSubacEntity {
  final String surahName;
  final int ayahNumber;
  final Timestamp dateTime;
  final int surahAyahLength;

  FetchDraftedSubacEntity({
    required this.ayahNumber,
    required this.dateTime,
    required this.surahName,
    required this.surahAyahLength,
  });
}
