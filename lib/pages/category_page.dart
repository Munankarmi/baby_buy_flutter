import 'package:baby_buy/providers/category_provider.dart';
import 'package:baby_buy/utils/extensions.dart';
import 'package:baby_buy/widgets/category_tile.dart';
import 'package:baby_buy/utils/elev_button_style.dart';
import 'package:baby_buy/utils/text_field_style.dart';
import 'package:baby_buy/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final categoryNameController = TextEditingController();
  final categoryDescpController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryProvider>().fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Consumer<CategoryProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.categoryListGetter.length,
            itemBuilder: (context, index) {
              return CategoryTile(
                index: index,
                categoryText: value.categoryListGetter[index][1],
                descriptionText: value.categoryListGetter[index][2],
              );
            },
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
                  borderRadius: BorderRadius.circular(26),
                ),
                backgroundColor: Colors.grey,
                title: StyleText(
                  text: "Add Category",
                  textWeight: true,
                  textSize: 30,
                  textColor: Colors.black,
                  textSpace: 1,
                ),
                content: SizedBox(
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
                      SizedBox(height: 20),
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
                            buttonPressed: () {
                              if (categoryNameController.text.isEmpty ||
                                  categoryDescpController.text.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.grey,
                                    title: StyleText(
                                      text: "Error !!!",
                                      textSize: 40,
                                      textWeight: true,
                                      textColor: Colors.red,
                                    ),
                                    content: StyleText(
                                      text: "Please fill all required text",
                                      textColor: Colors.black,
                                    ),
                                    actions: [
                                      ElevButtonStyle(
                                        buttonText: " Okay ",
                                        buttonPressed: () =>
                                            Navigator.pop(context),
                                      ),
                                    ],
                                  ),
                                );
                                return;
                              } else {
                                context.categoryProvider.saveCategory(
                                  categoryNameController.text,
                                  categoryDescpController.text,
                                );
                                categoryNameController.clear();
                                categoryDescpController.clear();
                                Navigator.pop(context);
                              }
                            },
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
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
          side: BorderSide(color: Colors.white, width: 2),
        ),
        child: Icon(Icons.add, color: Colors.lightBlueAccent),
      ),
    );
  }
}
