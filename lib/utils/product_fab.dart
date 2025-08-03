import 'package:baby_buy/providers/category_provider.dart';
import 'package:baby_buy/providers/product_provider.dart';
import 'package:baby_buy/utils/elev_button_style.dart';
import 'package:baby_buy/utils/extensions.dart';
import 'package:baby_buy/utils/sign_button_style.dart';
import 'package:baby_buy/utils/text_field_style.dart';
import 'package:baby_buy/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class ProductFab extends StatefulWidget {
  const ProductFab({super.key});

  @override
  State<ProductFab> createState() => _ProductFabState();
}

class _ProductFabState extends State<ProductFab> {
  int? index;
  File? productImage;
  String? productName;
  String? productDescp;
  String? productCategory;
  int? productPrice;
  int? productQty;

  final fabProductTextController = TextEditingController();
  final fabProductDescpController = TextEditingController();
  String? selectedValue;
  final fabProductPriceController = TextEditingController();
  final fabProductQuantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ProductProvider>(context);
    final image = imageProvider.imageFile;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 80,
          backgroundImage: image != null ? FileImage(image) : null,
          child: imageProvider.imageFile == null
              ? Icon(Icons.person, size: 60)
              : null,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevButtonStyle(
              buttonText: "Gallery",
              buttonPressed: () {
                Provider.of<ProductProvider>(
                  context,
                  listen: false,
                ).pickImageFromGallery();
              },
            ),
            SizedBox(width: 20),
            ElevButtonStyle(
              buttonText: "Camera",
              buttonPressed: () {
                Provider.of<ProductProvider>(
                  context,
                  listen: false,
                ).pickImageFromCamera();
              },
            ),
          ],
        ),
        SizedBox(height: 30),

        TextFieldStyle(
          hintText: "Product",
          textController: fabProductTextController,
        ),
        SizedBox(height: 10),
        TextFieldStyle(
          hintText: "Description",
          textController: fabProductDescpController,
        ),
        SizedBox(height: 10),
        Consumer<CategoryProvider>(
          builder: (context, data, child) {
            return DropdownButton(
              hint: StyleText(text: "Select Category"),
              value: selectedValue,
              items: data.categoryListGetter.map<DropdownMenuItem<String>>((item) {
                return DropdownMenuItem<String>(
                  value: item[0],
                  child: Text(item[1]),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
            );
          },
        ),

        TextFieldStyle(
          hintText: "Price",
          textController: fabProductPriceController,
          kType: TextInputType.number,
        ),
        SizedBox(height: 10),

        TextFieldStyle(
          hintText: "Quantity",
          textController: fabProductQuantityController,
          kType: TextInputType.number,
        ),
        SizedBox(height: 20),

        SignButtonStyle(
          text: "Add",
          onTap: () {
            context.productProvider.addProduct(
              image,
              fabProductTextController.text,
              fabProductDescpController.text,
              selectedValue ?? "Unknown",
              int.tryParse(fabProductPriceController.text) ?? 0,
              int.tryParse(fabProductQuantityController.text) ?? 0,
            );
            Provider.of<ProductProvider>(context, listen: false).clearImge();
            fabProductTextController.clear();
            fabProductDescpController.clear();
            fabProductDescpController.clear();
            fabProductPriceController.clear();
            fabProductQuantityController.clear();
            Navigator.pop(context);
          },
        ),
        SizedBox(height: 30),
        ElevButtonStyle(
          buttonText: "Cancel",
          buttonPressed: () {
            Navigator.pop(context);
            Provider.of<ProductProvider>(context, listen: false).clearImge();
          },
        ),
      ],
    );
  }
}
