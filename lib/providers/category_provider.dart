import 'package:flutter/widgets.dart';

class CategoryProvider extends ChangeNotifier {
  List categoryList = [
    ['Baby Clothes', 'asdsadsad asdsadsad kmsdfdsfdsf'],
    ['Diaper', 'asdaskdjasldjsladjsd aslkdjaslkdjasld asljdslaj'],
  ];

  get CategoryList => categoryList;
  void saveCategory(String name, String desc) {
    CategoryList.add([name, desc]);
    notifyListeners();
  }

  void removeCategory(int index) {

    CategoryList.remove(CategoryList[index]);
 
    notifyListeners();
  }

  void editCategory(int index, String name, String descp) {
    CategoryList[index]=[ name, descp];
    notifyListeners();
  }
}
