import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePageProvider extends ChangeNotifier {
  ImageProvider _getImageProvider(String path) {
    if (path.startsWith('http')) {
      return NetworkImage(path);
    } else {
      return AssetImage(path);
    }
  }

  get getImageProvider => _getImageProvider;

  List<Map<String, dynamic>> purchasedList = [];
  get purchasedListGetter => purchasedList;

  Future<void> addToPurchasedList(List itemCopy) async {
    String originalProductId = itemCopy[0];

    bool itemExists = purchasedList.any(
      (element) => element['originalProductId'] == originalProductId,
    );
    if (!itemExists) {
      Map<String, dynamic> itemMap = {
        'originalProductId': itemCopy[0],
        'image': itemCopy[1],
        'name': itemCopy[2],
        'descp': itemCopy[3],
        'category': itemCopy[4],
        'price': itemCopy[5],
        'qty': itemCopy[6],
        'checkBox': itemCopy[7],
        'createdAt': FieldValue.serverTimestamp(),
      };

      DocumentReference docref = await FirebaseFirestore.instance
          .collection('babyBuy-purchased-products')
          .add(itemMap);

      purchasedList.add({
        'purchasedId': docref.id,
        'originalProductId': originalProductId,
        'data': List.from(itemCopy),
      });

      notifyListeners();
    }
  }

  Future<void> fetchPurchasedList() async {
    try {
      final querSnapShot = await FirebaseFirestore.instance
          .collection('babyBuy-purchased-products')
          .orderBy('createdAt', descending: true)
          .get();
      purchasedList = querSnapShot.docs.map((doc) {
        final data = doc.data();
        return {
          'purchasedId': doc.id,
          'originalProductId': data['originalProductId'],
          'data': [
            data['originalProductId'],
            data['image'],
            data['name'],
            data['descp'],
            data['category'],
            data['price'],
            data['qty'],
            data['checkBox'],
          ],
        };
      }).toList();
      notifyListeners();
    } catch (e) {
      print("something went wrong");
      throw e;
    }
  }

  Future<void> removeFromPurchasedList(String originalProductId) async {
    try {
      int itemIndex = purchasedList.indexWhere(
        (element) => element['originalProductId'] == originalProductId,
      );
      if (itemIndex == -1) {
        print("Item not found in purchased list: $originalProductId");
        return;
      }

      String purchasedId = purchasedList[itemIndex]['purchasedId'];
      await FirebaseFirestore.instance
          .collection('babyBuy-purchased-products')
          .doc(purchasedId)
          .delete();

      purchasedList.removeAt(itemIndex);
      notifyListeners();
    } catch (e) {
      print('Something went worng');
      throw e;
    }
  }
}
