import 'dart:ffi';

import 'package:baby_buy/utils/elev_button_style.dart';
import 'package:baby_buy/utils/product_fab.dart';
import 'package:baby_buy/utils/text_style.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});
  final List productList = [
    [
      'lib/assets/baby_ss.webp',
      "Diaper",
      "it's a diaper of size 30, asdasdsadsadasd asdasdasdasd ",
      20,
      5,
    ],
    ['lib/assets/baby_ss.webp', "Diaper", "asdsadsad ", 20, 5],
    ['lib/assets/baby_ss.webp', "Diaper", "asdsadsad ", 20, 5],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: Image.asset(productList[index][0]),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StyleText(
                      text: productList[index][1],
                      textWeight: true,
                      textSize: 16,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyleText(
                          text: "\$ " + productList[index][3].toString(),
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
                        text: productList[index][2],
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
                          text: "Qty:" + productList[index][4].toString(),
                          textWeight: true,
                          textSize: 14,
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit_square),
                  iconSize: 40,
                ),
              ),
            ),
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
