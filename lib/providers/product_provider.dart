import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductProvider extends ChangeNotifier {
  File? _imageFile;
  File? get imageFile => _imageFile;
  final ImagePicker _picker = ImagePicker();

  List productList = [
    [
      'lib/assets/baby_ss.webp',
      "wishper",
      "it's a diaper of size 30, asdasdsadsadasd asdasdasdasd ",
      "Diaper",
      20,
      5,
    ],
    ['lib/assets/baby_ss.webp', "wishper", "asdsadsad ", "Diaper", 20, 5],
    ['lib/assets/baby_ss.webp', "wishper", "asdsadsad ", "Diaper", 20, 5],
  ];
  get ProductList => productList;

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

  void addProduct(
    File? pImage,
    String pName,
    String descp,
    String cName,
    int price,
    int qty,
  ) {
    productList.add([pImage, pName, descp, cName, price, qty]);
    notifyListeners();
  }

  void deleteProduct(int index) {
    ProductList.removeAt(index);
    notifyListeners();
  }
}
