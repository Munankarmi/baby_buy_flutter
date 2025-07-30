import 'package:baby_buy/pages/category_page.dart';
import 'package:baby_buy/pages/inside_home_page.dart';
import 'package:baby_buy/pages/login_page.dart';
import 'package:baby_buy/pages/product_page.dart';
import 'package:baby_buy/providers/product_provider.dart';
import 'package:baby_buy/utils/elev_button_style.dart';
import 'package:baby_buy/utils/extensions.dart';
import 'package:baby_buy/utils/product_fab.dart';
import 'package:baby_buy/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Widget> pages = [InsideHomePage(), CategoryPage(), ProductPage()];

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ProductProvider>(context);
    final image = imageProvider.imageFile;
    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        title: StyleText(text: "Baby Buy", textWeight: true, textSize: 30),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[600],
        elevation: 2,
        shadowColor: Colors.white,
      ),
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: Colors.lightBlue[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: StyleText(text: "Choose Image from:"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  ElevButtonStyle(
                                    buttonText: "Gallery",
                                    buttonPressed: () {
                                      context.productProvider
                                          .pickImageFromGallery();
                                      Navigator.pop(context);
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  ElevButtonStyle(
                                    buttonText: "Camera",
                                    buttonPressed: () {
                                      context.productProvider
                                          .pickImageFromCamera();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              ElevButtonStyle(
                                buttonText: "Cancel",
                                buttonPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.lightBlue[600],
                    backgroundImage: image != null ? FileImage(image) : null,
                    child: image == null ? Icon(Icons.person, size: 60) : null,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: Text(
                  "Name",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Username",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              Divider(thickness: 1, color: Colors.lightBlue[800]),
              SizedBox(height: 30),

              TextButton.icon(
                onPressed: () {
                  currentPage(2);
                  Navigator.pop(context);
                },
                label: Text(
                  "Products",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[800],
                  ),
                ),
                icon: Icon(
                  Icons.account_tree_sharp,
                  size: 50,
                  color: Colors.lightBlue[800],
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  currentPage(1);
                  Navigator.pop(context);
                },
                label: Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.lightBlue[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: Icon(
                  Icons.category,
                  size: 50,
                  color: Colors.lightBlue[800],
                ),
              ),
              SizedBox(height: 30),
              Divider(thickness: 1, color: Colors.lightBlue[800]),
              SizedBox(height: 20),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.message,
                  size: 50,
                  color: Colors.lightBlue[800],
                ),
                label: Text(
                  "Send SMS",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[800],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Divider(thickness: 1, color: Colors.lightBlue[800]),
              SizedBox(height: 50),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                label: Text(
                  "LogOut",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[800],
                  ),
                ),
                icon: Icon(
                  Icons.logout,
                  size: 50,
                  color: Colors.lightBlue[800],
                ),
              ),
            ],
          ),
        ),
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (int index) {
          currentPage(index);
        },

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 40, color: Colors.black54),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category, size: 40, color: Colors.black54),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_tree_sharp,
              size: 40,
              color: Colors.black54,
            ),
            label: "Product",
          ),
        ],
        backgroundColor: Colors.lightBlue[600],
      ),
    );
  }

  void currentPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
