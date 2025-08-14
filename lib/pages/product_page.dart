import 'dart:io';

import 'package:baby_buy/providers/product_provider.dart';
import 'package:baby_buy/utils/elev_button_style.dart';
import 'package:baby_buy/utils/extensions.dart';
import 'package:baby_buy/utils/product_fab.dart';
import 'package:baby_buy/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool _isFetched = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isFetched) {
      context.productProvider.fetchProduct();
      _isFetched = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<ProductProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.productList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        offset: Offset(2, 2),
                        blurRadius: 2,
                        spreadRadius: 1
                      ),
                      BoxShadow(
                        color: Colors.lightBlueAccent,
                        offset: Offset(-2, -2),
                        blurRadius: 2, 
                        spreadRadius: 1
                      )
                    ],
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              final img = value.productListGetter[index][1];
                              Widget imageWidget;

                              if (img is String && img.startsWith('http')) {
                                imageWidget = Image.network(
                                  img,
                                  fit: BoxFit.fill,
                                  errorBuilder:
                                      (context, error, StackTrace? stackTrace) {
                                        return const Icon(Icons.broken_image);
                                      },
                                );
                              } else if (img is File) {
                                imageWidget = Image.file(img, fit: BoxFit.fill);
                              } else if (img is String) {
                                imageWidget = Image.asset(
                                  img,
                                  fit: BoxFit.fill,
                                );
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
                        Expanded(
                          child: StyleText(
                            text: value.productList[index][2],
                            textSize: 16,
                            textWeight: true,
                          ),
                        ),
                      ],
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyleText(
                          text: value.productList[index][4],
                          textWeight: true,
                          textSize: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StyleText(
                              text:
                                  "\$ ${value.productList[index][5].toString()}",
                              textWeight: true,
                              textSize: 14,
                              textSpace: 0,
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
                            text: value.productList[index][3],
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
                                  "Qty: ${value.productList[index][6].toString()}",
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
                            backgroundColor: Colors.grey,
                            title: StyleText(text: "Delete Product?", textColor: Colors.black, textWeight: true, textSpace: 1,),
                            actions: [
                              ElevButtonStyle(
                                buttonText: " Okay ",
                                buttonPressed: () {
                                  value.deleteProduct(index);
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(width: 16,),
                              ElevButtonStyle(
                                buttonText: "Cancel",
                                buttonPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: Icon(Icons.delete, color: Colors.lightBlueAccent,),
                      iconSize: 30,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: SingleChildScrollView(
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.grey,
              builder: (context) {
                return Padding(
                  padding: EdgeInsetsGeometry.only(left: 20, right: 20, top: 12, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
                  child: SingleChildScrollView(child: ProductFab()),
                );
              },
            );
          },
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.white, width: 2)
          ),
          child: Icon(Icons.add, color: Colors.lightBlueAccent,),
        ),
      ),
    );
  }
}
