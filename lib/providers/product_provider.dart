// import 'dart:convert';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';

// class ProductProvider extends ChangeNotifier {
//   File? _imageFile;
//   File? get imageFile => _imageFile;
//   final ImagePicker _picker = ImagePicker();
//   List productList = [];
//   get productListGetter => productList;

//   Future<void> pickImageFromGallery() async {
//     final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       _imageFile = File(pickedImage.path);
//     }
//     notifyListeners();
//   }

//   Future<void> pickImageFromCamera() async {
//     final pickedImage = await _picker.pickImage(source: ImageSource.camera);
//     if (pickedImage != null) {
//       _imageFile = File(pickedImage.path);
//     }
//     notifyListeners();
//   }

//   void clearImge() {
//     _imageFile = null;
//     notifyListeners();
//   }

//   Future<void> addProduct(
//     File? pImage,
//     String pName,
//     String descp,
//     String cName,
//     int price,
//     int qty,
//   ) async {
//     String? imageUrl;

//     if (pImage != null) {
//       final storageRef = FirebaseStorage.instance.ref().child(
//         'product_images/${DateTime.now().millisecondsSinceEpoch}.jpg',
//       );

//       final uploadImage = await storageRef.putFile(pImage);
//       imageUrl = await uploadImage.ref.getDownloadURL();
//     }

//     final doc = {
//       'image': imageUrl,
//       'name': pName,
//       'descp': descp,
//       'category': cName,
//       'price': price,
//       'qty': qty,
//       'createdAt': FieldValue.serverTimestamp(),
//     };
//     final docref = await FirebaseFirestore.instance
//         .collection('babyBuy-products')
//         .add(doc);
//     productList.add([docref.id, imageUrl, pName, descp, cName, price, qty]);
//     notifyListeners();
//   }

//   Future<void> fetchProduct() async {
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection('babyBuy-products')
//         .orderBy('createdAt', descending: true)
//         .get();

//     productList = querySnapshot.docs.map((doc) {
//       final data = doc.data();
//       return [
//         doc.id,
//         data['image'],
//         data['name'],
//         data['descp'],
//         data['category'],
//         data['price'],
//         data['qty'],
//       ];
//     }).toList();
//     notifyListeners();
//   }

//   Future<void> deleteProduct(int index) async {
//     final docId = productList[index][0];
//     await FirebaseFirestore.instance
//         .collection('babyBuy-products')
//         .doc(docId)
//         .delete();
//     productListGetter.removeAt(index);
//     notifyListeners();
//   }

//   Future<void> uploadImageClaudinary()async{
//     final claudinaryUrl = Uri.parse('https://api.cloudinary.com/v1_1/ddinm2kar/upload');

//     final request = http.MultipartRequest('Post', claudinaryUrl)
//     ..fields['upload_preset'] = 'babyBuy-products'
//     ..files.add(await http.MultipartFile.fromPath('file', _imagefile!.path));
//     final response = await request.send();
//     if(response.statusCode == 200){
//       final responseData = response.stream.toBytes();
//       final responseString = String.fromCharCode(responseData);
//       final jsonMap = jsonDecode(responseString);
//       final claudinaryUrl = jsonMap['url'];
//       _imageUrl = url;
//     }
//   }
// }


import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProductProvider extends ChangeNotifier {
  File? _imageFile;
  File? get imageFile => _imageFile;
  String? _imageUrl; // Add this to store Cloudinary URL
  String? get imageUrl => _imageUrl;
  
  final ImagePicker _picker = ImagePicker();
  List productList = [];
  get productListGetter => productList;

  Future<void> pickImageFromGallery() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _imageFile = File(pickedImage.path);
      _imageUrl = null; // Clear previous URL when new image is picked
    }
    notifyListeners();
  }

  Future<void> pickImageFromCamera() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      _imageFile = File(pickedImage.path);
      _imageUrl = null; // Clear previous URL when new image is picked
    }
    notifyListeners();
  }

  void clearImage() {
    _imageFile = null;
    _imageUrl = null;
    notifyListeners();
  }

  // Fixed Cloudinary upload method
  Future<String?> uploadImageToCloudinary() async {
    if (_imageFile == null) return null;

    try {
      final cloudinaryUrl = Uri.parse('https://api.cloudinary.com/v1_1/ddinm2kar/image/upload');
      
      final request = http.MultipartRequest('POST', cloudinaryUrl)
        ..fields['upload_preset'] = 'babyBuy-products'
        ..files.add(await http.MultipartFile.fromPath('file', _imageFile!.path));
      
      final response = await request.send();
      
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        final cloudinaryImageUrl = jsonMap['secure_url']; // Use secure_url for HTTPS
        
        _imageUrl = cloudinaryImageUrl;
        notifyListeners();
        return cloudinaryImageUrl;
      } else {
        print('Failed to upload image to Cloudinary. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error uploading to Cloudinary: $e');
      return null;
    }
  }

  // Modified addProduct method to use Cloudinary
  Future<void> addProduct(
    File? pImage,
    String pName,
    String descp,
    String cName,
    int price,
    int qty,
  ) async {
    String? imageUrl;

    if (pImage != null) {
      // Upload to Cloudinary instead of Firebase Storage
      imageUrl = await uploadImageToCloudinary();
      
      if (imageUrl == null) {
        // Fallback to Firebase Storage if Cloudinary fails
        print('Cloudinary upload failed, falling back to Firebase Storage');
        final storageRef = FirebaseStorage.instance.ref().child(
          'product_images/${DateTime.now().millisecondsSinceEpoch}.jpg',
        );
        
        final uploadImage = await storageRef.putFile(pImage);
        imageUrl = await uploadImage.ref.getDownloadURL();
      }
    }

    final doc = {
      'image': imageUrl,
      'name': pName,
      'descp': descp,
      'category': cName,
      'price': price,
      'qty': qty,
      'createdAt': FieldValue.serverTimestamp(),
    };

    try {
      final docref = await FirebaseFirestore.instance
          .collection('babyBuy-products')
          .add(doc);
      
      productList.add([docref.id, imageUrl, pName, descp, cName, price, qty]);
      notifyListeners();
    } catch (e) {
      print('Error adding product to Firestore: $e');
      throw e;
    }
  }

  // Alternative method to add product with pre-uploaded Cloudinary URL
  Future<void> addProductWithCloudinaryImage(
    String pName,
    String descp,
    String cName,
    int price,
    int qty,
  ) async {
    // First upload the image to Cloudinary
    String? imageUrl = await uploadImageToCloudinary();
    
    if (imageUrl == null) {
      throw Exception('Failed to upload image to Cloudinary');
    }

    final doc = {
      'image': imageUrl,
      'name': pName,
      'descp': descp,
      'category': cName,
      'price': price,
      'qty': qty,
      'createdAt': FieldValue.serverTimestamp(),
    };

    try {
      final docref = await FirebaseFirestore.instance
          .collection('babyBuy-products')
          .add(doc);
      
      productList.add([docref.id, imageUrl, pName, descp, cName, price, qty]);
      notifyListeners();
    } catch (e) {
      print('Error adding product to Firestore: $e');
      throw e;
    }
  }

  Future<void> fetchProduct() async {
    try {
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
    } catch (e) {
      print('Error fetching products: $e');
      throw e;
    }
  }

  Future<void> deleteProduct(int index) async {
    final docId = productList[index][0];
    
    try {
      await FirebaseFirestore.instance
          .collection('babyBuy-products')
          .doc(docId)
          .delete();
      
      productList.removeAt(index);
      notifyListeners();
    } catch (e) {
      print('Error deleting product: $e');
      throw e;
    }
  }
}