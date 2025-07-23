import 'package:baby_buy/styles/elev_button_style.dart';
import 'package:baby_buy/styles/sign_button_style.dart';
import 'package:baby_buy/styles/text_field_style.dart';
import 'package:baby_buy/styles/text_style.dart';
import 'package:flutter/material.dart';

final List<List<String>> categoryListTile = [
  ['Diaper', 'asdaskdjasldjsladjsd aslkdjaslkdjasld asljdslaj'],
  ['Baby Clothes', 'asdsadsad asdsadsad kmsdfdsfdsf'],
];

class CategoryPage extends StatelessWidget {
  final categoryNameController = TextEditingController();
  final categoryDescpController = TextEditingController();
  CategoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue,
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            StyleText(text: "Category:", textColor: Colors.white),
            // StyleText(text: categoryListTile.length[][0], textWeight: true),
            SizedBox(height: 10),
            Divider(thickness: 1, color: Colors.lightBlue[100]),
            SizedBox(height: 10),
            StyleText(text: "Description:"),
            // Text(categoryListTile[categoryListTile.length][1]),
            SizedBox(height: 30),
            SignButtonStyle(text: "Edit Category", onTap: () {}),
            SizedBox(height: 10),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.lightBlue[400],
                title: StyleText(
                  text: "Add Category",
                  textWeight: true,
                  textSize: 30,
                  textColor: Colors.white,
                ),
                content: Container(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFieldStyle(
                        hintText: "Category Name",
                        textController: categoryNameController,
                      ),
                      SizedBox(height: 10),
                      TextFieldStyle(
                        hintText: "Description",
                        textController: categoryDescpController,
                        textFieldSize: 30,
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevButtonStyle(
                            buttonText: "Cancel",
                            buttonPressed: () {
                              Navigator.pop(context);
                              categoryNameController.clear();
                              categoryDescpController.clear();
                            },
                          ),
                          SizedBox(width: 30),
                          ElevButtonStyle(
                            buttonText: "  Save  ",
                            buttonPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.lightBlue[400],
        child: Icon(Icons.add),
      ),
    );
  }
}
