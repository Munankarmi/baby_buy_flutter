import 'package:baby_buy/utils/elev_button_style.dart';
import 'package:baby_buy/utils/extensions.dart';
import 'package:baby_buy/utils/sign_button_style.dart';
import 'package:baby_buy/utils/text_field_style.dart';
import 'package:baby_buy/utils/text_style.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatefulWidget {
  final int index;
  final String categoryText;
  final String descriptionText;
  const CategoryTile({
    required this.index,
    required this.categoryText,
    required this.descriptionText,
    super.key,
  });

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  final categoryNameController = TextEditingController();
  final categoryDescpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    categoryNameController.text = widget.categoryText;
    categoryDescpController.text = widget.descriptionText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black87,
      ),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StyleText(
                text: "Category:",
                textColor: Colors.white,
                textSize: 12,
                textWeight: true,
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.grey,
                      title: StyleText(
                        text: "Delete Category?",
                        textWeight: true,
                        textSize: 20,
                        textColor: Colors.black,
                        textSpace: 1,
                      ),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevButtonStyle(
                            buttonText: " Okay ",
                            buttonPressed: () {
                              context.categoryProvider.removeCategory(
                                widget.index,
                              );
                              Navigator.pop(context);
                            },
                          ),

                          ElevButtonStyle(
                            buttonText: "Cancel",
                            buttonPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.delete, color: Colors.white),
              ),
            ],
          ),
          StyleText(text: widget.categoryText, textWeight: true),
          Divider(thickness: 1, color: Colors.white),
          StyleText(
            text: "Description:",
            textColor: Colors.white,
            textSize: 12,
            textWeight: true,
          ),
          StyleText(text: widget.descriptionText, textWeight: true),
          SizedBox(height: 15),
          SignButtonStyle(
            text: "Edit Category",
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.grey,
                    title: StyleText(
                      text: "Edit Category",
                      textWeight: true,
                      textSize: 30,
                      textColor: Colors.black,
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
                                },
                              ),
                              SizedBox(width: 30),
                              ElevButtonStyle(
                                buttonText: "  Save  ",
                                buttonPressed: () {
                                  context.categoryProvider.editCategory(
                                    widget.index,
                                    categoryNameController.text,
                                    categoryDescpController.text,
                                  );
                                  Navigator.pop(context);
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
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
