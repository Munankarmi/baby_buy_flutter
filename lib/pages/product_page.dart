import 'dart:io';

import 'package:baby_buy/providers/product_provider.dart';
import 'package:baby_buy/utils/elev_button_style.dart';
import 'package:baby_buy/utils/product_fab.dart';
import 'package:baby_buy/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Consumer<ProductProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.productList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: Column(
                      children: [
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              final img = value.ProductList[index][0];
                              Widget imageWidget;

                              if (img is String) {
                                imageWidget = Image.asset(
                                  img,
                                  fit: BoxFit.fill,
                                );
                              } else if (img is File) {
                                imageWidget = Image.file(img, fit: BoxFit.fill);
                              } else {
                                imageWidget = const Icon(
                                  Icons.image_not_supported,
                                );
                              }

                              return SizedBox(
                                height: 60,
                                width: 60,
                                child: imageWidget,
                              );
                            },
                          ),
                        ),
                        StyleText(
                          text: value.productList[index][1],
                          textSize: 8,
                          textWeight: true,
                        ),
                      ],
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyleText(
                          text: value.productList[index][3],
                          textWeight: true,
                          textSize: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StyleText(
                              text:
                                  "\$ " +
                                  value.productList[index][4].toString(),
                              textWeight: true,
                              textSize: 14,
                            ),
                            // StyleText(
                            //   text: "Qty:" + productList[index][4].toString(),
                            //   textWeight: true,
                            //   textSize: 14,
                            // ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: StyleText(
                            text: value.productList[index][2],
                            textSize: 12,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // StyleText(
                            //   text: "\$ " + productList[index][3].toString(),
                            //   textWeight: true,
                            //   textSize: 14,
                            // ),
                            StyleText(
                              text:
                                  "Qty:" +
                                  value.productList[index][5].toString(),
                              textWeight: true,
                              textSize: 14,
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: StyleText(text: "Delete Product?"),
                            actions: [
                              ElevButtonStyle(
                                buttonText: "Okay",
                                buttonPressed: () {
                                  value.deleteProduct(index);
                                  Navigator.pop(context);
                                },
                              ),
                              ElevButtonStyle(
                                buttonText: "Cancel",
                                buttonPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        );

                      },
                      icon: Icon(Icons.delete),
                      iconSize: 40,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.lightBlue[400],
            builder: (context) {
              return Padding(
                padding: EdgeInsetsGeometry.all(20),
                child: ProductFab(),
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
