import 'package:baby_buy/utils/sign_button_style.dart';
import 'package:baby_buy/utils/text_style.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String categoryText;
  final String descriptionText;
  const CategoryTile({
    required this.categoryText,
    required this.descriptionText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.lightBlue[600],
      ),
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          StyleText(
            text: "Category:",
            textColor: Colors.white,
            textSize: 12,
            textWeight: true,
          ),
          StyleText(text: categoryText, textWeight: true),
          Divider(thickness: 1, color: Colors.lightBlue[100]),
          StyleText(
            text: "Description:",
            textColor: Colors.white,
            textSize: 12,
            textWeight: true,
          ),
          StyleText(text: descriptionText, textWeight: true),
          SizedBox(height: 15),
          SignButtonStyle(text: "Edit Category", onTap: () {}),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
