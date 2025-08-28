import 'package:baby_buy/pages/purchased_products.dart';
import 'package:baby_buy/providers/home_page_provider.dart';
import 'package:baby_buy/providers/product_provider.dart';
import 'package:baby_buy/utils/elev_button_style.dart';
import 'package:baby_buy/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InsideHomePage extends StatefulWidget {
  const InsideHomePage({super.key});

  @override
  State<InsideHomePage> createState() => _InsideHomePageState();
}

class _InsideHomePageState extends State<InsideHomePage> {
  bool _isFetched = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isFetched) {
      Provider.of<ProductProvider>(context, listen: false).fetchProduct();
      _isFetched = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<HomePageProvider>(
        builder: (context, value, child) {
          final productProvier = context.watch<ProductProvider>();
          return ListView.builder(
            itemCount: productProvier.productList.length,
            itemBuilder: (context, index) {
              return IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black87,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        offset: Offset(2, 2),
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Colors.lightBlueAccent,
                        offset: Offset(-2, -2),
                        blurRadius: 1,
                        spreadRadius: 1,
                      ),
                    ],
                  ),

                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: value.getImageProvider(
                                productProvier.productListGetter[index][1],
                              ),
                            ),
                            StyleText(
                              text: productProvier.productListGetter[index][2],
                              textSize: 16,
                              textWeight: true,
                              textSpace: 2,
                              textColor: Colors.white,
                            ),
                          ],
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StyleText(
                                  text: productProvier
                                      .productListGetter[index][4],
                                  textSize: 16,
                                  textWeight: true,
                                  textColor: Colors.white,
                                ),
                                StyleText(
                                  text: productProvier
                                      .productListGetter[index][3],
                                  textSize: 14,
                                  textSpace: 1,
                                  textColor: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StyleText(
                                text:
                                    '\$ ${productProvier.productListGetter[index][5]}',
                                textSize: 14,
                                textColor: Colors.white,
                                textWeight: true,
                                textSpace: 0,
                              ),
                              StyleText(
                                text:
                                    'Qty: ${productProvier.productListGetter[index][6]}',
                                textSize: 14,
                                textColor: Colors.white,
                                textWeight: true,
                                textSpace: 0,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                final product =
                                    productProvier.productListGetter[index];
                                final alreadyPurchased = value
                                    .purchasedListGetter
                                    .any(
                                      (element) =>
                                          element['originalProductId'] ==
                                          product[0],
                                    );
                                if (alreadyPurchased) {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      backgroundColor: Colors.grey,
                                      title: StyleText(
                                        text: "Already purchased",
                                        textWeight: true,
                                        textColor: Colors.black,
                                      ),
                                      content: StyleText(
                                        text:
                                            "This product is already in your purchased list, Check inside your cart.",
                                        textSpace: 1,
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
                                } else {
                                  value.addToPurchasedList(
                                    productProvier.productListGetter[index],
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      backgroundColor: Colors.grey,
                                      title: StyleText(
                                        text: "Product Added",
                                        textWeight: true,
                                        textColor: Colors.black,
                                      ),
                                      content: StyleText(
                                        text:
                                            "This Product is Added in your Cart.",
                                        textSpace: 1,
                                        textColor: Colors.black,
                                      ),
                                      actions: [
                                        ElevButtonStyle(
                                          buttonText: ' Okay ',
                                          buttonPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                              icon: Icon(
                                Icons.add_shopping_cart,
                                color: Colors.lightBlueAccent,
                              ),
                            ),

                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.lightBlueAccent,
                              ),
                              onPressed: () {
                                productProvier.deleteProduct(index);
                              },
                            ),
                          ],
                        ),
                      ],
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
            builder: (context) {
              return PurchasedProducts();
            },
          );
        },
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
          side: BorderSide(color: Colors.white, width: 2),
        ),
        child: Icon(Icons.card_travel, color: Colors.lightBlueAccent),
      ),
    );
  }
}
