import 'package:baby_buy/utils/category_tile.dart';
import 'package:baby_buy/utils/elev_button_style.dart';
import 'package:baby_buy/utils/sign_button_style.dart';
import 'package:baby_buy/utils/text_field_style.dart';
import 'package:baby_buy/utils/text_style.dart';
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
      body: ListView.builder(
        itemCount: categoryListTile.length,
        itemBuilder: (context, index) {
          return CategoryTile(
            categoryText: categoryListTile[index][0],
            descriptionText: categoryListTile[index][1],
          );
        },
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
