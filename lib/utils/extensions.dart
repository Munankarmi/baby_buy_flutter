import 'package:baby_buy/providers/category_provider.dart';
import 'package:baby_buy/providers/product_provider.dart';
import 'package:baby_buy/providers/sign_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension Providers on BuildContext {
  CategoryProvider get categoryProvider =>
      Provider.of<CategoryProvider>(this, listen: false);
  ProductProvider get productProvider =>
      Provider.of<ProductProvider>(this, listen: false);
  SignProvider get signProvider =>
      Provider.of<SignProvider>(this, listen: false);
}
