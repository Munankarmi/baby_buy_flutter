import 'package:baby_buy/providers/home_page_provider.dart';
import 'package:baby_buy/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchasedProducts extends StatefulWidget {
  const PurchasedProducts({super.key});

  @override
  State<PurchasedProducts> createState() => _PurchasedProductsState();
}

class _PurchasedProductsState extends State<PurchasedProducts> {
  bool _isFetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isFetched) {
      Provider.of<HomePageProvider>(
        context,
        listen: false,
      ).fetchPurchasedList();
      _isFetched = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<HomePageProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.purchasedList.length,
            itemBuilder: (context, index) {
              return IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
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
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: value.getImageProvider(
                                  value.purchasedList[index]['data'][1],
                                ),
                              ),
                            ),
                            StyleText(
                              text: value.purchasedList[index]['data'][2],
                              textWeight: true,
                              textSpace: 1,
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StyleText(
                              text: value.purchasedList[index]['data'][4],
                              textWeight: true,
                              textColor: Colors.white,
                            ),
                            StyleText(
                              text: value.purchasedList[index]['data'][3],
                              textSize: 12,
                              textSpace: 1,
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StyleText(
                            text:
                                "\$ ${value.purchasedList[index]['data'][5].toString()}",
                            textSpace: 0,
                            textSize: 16,
                            textWeight: true,
                          ),
                          StyleText(
                            text:
                                "Qty: ${value.purchasedList[index]['data'][6].toString()}",
                            textSize: 16,
                            textWeight: true,
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.lightBlueAccent,
                        onPressed: () {
                          value.removeFromPurchasedList(
                            value.purchasedList[index]['data'][0],
                          );
                        },
                      ),
                    ],
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
