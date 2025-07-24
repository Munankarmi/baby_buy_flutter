import 'package:baby_buy/utils/elev_button_style.dart';
import 'package:baby_buy/utils/sign_button_style.dart';
import 'package:baby_buy/utils/text_field_style.dart';
import 'package:flutter/material.dart';

class ProductFab extends StatefulWidget {
 const ProductFab({super.key});

  @override
  State<ProductFab> createState() => _ProductFabState();
}

class _ProductFabState extends State<ProductFab> {
  final fabProductTextController = TextEditingController();

  final fabProductDescpController = TextEditingController();

  final fabProductPriceController = TextEditingController();

  final fabProductQuantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 80,
          
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevButtonStyle(buttonText: "Gallery", buttonPressed: () {}),
            SizedBox(width: 20),
            ElevButtonStyle(buttonText: "Camera", buttonPressed: () {}),
          ],
        ),
        SizedBox(height: 40),

        TextFieldStyle(
          hintText: "Product",
          textController: fabProductTextController,
        ),
        SizedBox(height: 20),
        TextFieldStyle(
          hintText: "Description",
          textController: fabProductDescpController,
        ),
        SizedBox(height: 20),

        TextFieldStyle(
          hintText: "Price",
          textController: fabProductPriceController,
        ),
        SizedBox(height: 20),

        TextFieldStyle(
          hintText: "Quantity",
          textController: fabProductQuantityController,
        ),
        SizedBox(height: 40),

        SignButtonStyle(text: "Add", onTap: () {}),
        SizedBox(height: 40),
        ElevButtonStyle(
          buttonText: "Cancel",
          buttonPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
