import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class CategoryProvider extends ChangeNotifier {
  List categoryList = [];

  List get categoryListGetter => categoryList;
  Future<void> saveCategory(String name, String descp) async {
    final doc = {
      'categoryName': name,
      'categoryDescription': descp,
      'createdAt': FieldValue.serverTimestamp(),
    };

    final docref = await FirebaseFirestore.instance
        .collection('babyBuy-category')
        .add(doc);
    categoryList.add([docref.id, name, descp]);
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('babyBuy-category')
        .orderBy('createdAt', descending: true)
        .get();

    categoryList = querySnapshot.docs.map((doc) {
      final data = doc.data();
      return [doc.id, data['categoryName'], data['categoryDescription']];
    }).toList();
    notifyListeners();
  }

  Future<void> removeCategory(int index) async {
    final docId = categoryList[index][0];
    await FirebaseFirestore.instance
        .collection('babyBuy-category')
        .doc(docId)
        .delete();
    categoryList.removeAt(index);
    notifyListeners();
  }

  Future<void> editCategory(int index, String name, String descp) async {
    final docId = categoryList[index][0];
    final updatedDoc = {
      'categoryName': name,
      'categoryDescription': descp,
    };
   await FirebaseFirestore.instance.collection('babyBuy-category').doc(docId).update(updatedDoc);
    categoryList[index] = [docId, name, descp];
    notifyListeners();
  }
}
