import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePageProvider extends ChangeNotifier {
  List<dynamic> purchasedList = [
    // [
    //   'lib/assets/baby_ss.webp',
    //   'praibn',
    //   'bajeey',
    //   'bajey of the house, only onae and only',
    //   500,
    //   1,
    //   false,
    // ],
    //  [
    //   'lib/assets/baby_ss.webp',
    //   'ayuz',
    //   'boka',
    //   'boka of the house, one and only',
    //   500,
    //   1,
    //   false,
    // ],
    //  [
    //   'lib/assets/baby_ss.webp',
    //   'rabin',
    //   'tripathi',
    //   'bajey of the house, only onae and only',
    //   500,
    //   4,
    //   false,
    // ],
  ];
  get purchasedListGetter => purchasedList;

  ImageProvider _getImageProvider(String path) {
    if (path.startsWith('http')) {
      return NetworkImage(path);
    } else {
      return AssetImage(path);
    }
  }
  get getImageProvider => _getImageProvider;

  Future<void> fetchDatatoPurchased() async{
    final querySnapshot = await FirebaseFirestore.instance.collection('babyBuy-Products').orderBy('createdAt', descending: true).get();
  }
}
