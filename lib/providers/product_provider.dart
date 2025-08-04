import 'dart:io';

import 'package:baby_buy/providers/category_provider.dart';
import 'package:baby_buy/widgets/category_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProductProvider extends ChangeNotifier {
  File? _imageFile;
  File? get imageFile => _imageFile;
  final ImagePicker _picker = ImagePicker();
  List productList = [
    // [
    //   'lib/assets/baby_ss.webp',
    //   "wishper",
    //   "it's a diaper of size 30, asdasdsadsadasd asdasdasdasd ",
    //   "Diaper",
    //   20,
    //   5,
    // ],
    // ['lib/assets/baby_ss.webp', "wishper", "asdsadsad ", "Diaper", 20, 5],
    // ['lib/assets/baby_ss.webp', "wishper", "asdsadsad ", "Diaper", 20, 5],
  ];
  get productListGetter => productList;

  Future<void> pickImageFromGallery() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _imageFile = File(pickedImage.path);
    }
    notifyListeners();
  }

  Future<void> pickImageFromCamera() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      _imageFile = File(pickedImage.path);
    }
    notifyListeners();
  }

  void clearImge() {
    _imageFile = null;
    notifyListeners();
  }

  Future<void> addProduct(
    File? pImage,
    String pName,
    String descp,
    String cName,
    int price,
    int qty,
  ) async {
    final doc = {
      'image': pImage,
      'name': pName,
      'descp': descp,
      'category': cName,
      'price': price,
      'qty': qty,
      'createdAt': FieldValue.serverTimestamp(),
    };
    final docref = await FirebaseFirestore.instance
        .collection('babyBuy-products')
        .add(doc);
    productList.add([docref.id, pImage, pName, descp, cName, price, qty]);
    notifyListeners();
  }

  Future<void> fetchProduct() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('babyBuy-products')
        .orderBy('createdAt', descending: true)
        .get();

    productList = querySnapshot.docs.map((doc) {
      final data = doc.data();
      return [
        doc.id,
        data['image'],
        data['name'],
        data['descp'],
        data['category'],
        data['price'],
        data['qty'],
      ];
    }).toList();
    notifyListeners();
  }

  Future<void> deleteProduct(int index) async {
    final docId = productList[index][0];
    await FirebaseFirestore.instance
        .collection('babyBuy-products')
        .doc(docId)
        .delete();
    productListGetter.removeAt(index);
    notifyListeners();
  }
}
