import 'package:baby_buy/providers/home_page_provider.dart';
import 'package:baby_buy/providers/product_provider.dart';
import 'package:baby_buy/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InsideHomePage extends StatefulWidget {
  const InsideHomePage({super.key});

  @override
  State<InsideHomePage> createState() => _InsideHomePageState();
}

class _InsideHomePageState extends State<InsideHomePage> {
  bool onPurchased = false;
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
      backgroundColor: Colors.blueAccent[100],
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
                    color: Colors.blueGrey,
                  ),

                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
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
                            ),
                          ],
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StyleText(
                                  text: productProvier
                                      .productListGetter[index][4],
                                  textSize: 16,
                                ),
                                StyleText(
                                  text: productProvier
                                      .productListGetter[index][3],
                                  textSize: 14,
                                  textSpace: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              StyleText(
                                text:
                                    '\$ ${productProvier.productListGetter[index][5]}',
                                textSize: 12,
                              ),
                              StyleText(
                                text:
                                    'Qty: ${productProvier.productListGetter[index][6]}',
                                textSize: 12,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Checkbox(
                              value: onPurchased,
                              onChanged: (value) {
                                setState(() {
                                  onPurchased = value!;
                                });
                              },
                              checkColor: Colors.blueGrey,
                              activeColor: Colors.green,
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {},
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
    );
  }
}
