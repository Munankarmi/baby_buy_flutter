import 'package:baby_buy/pages/category_page.dart';
import 'package:baby_buy/pages/inside_home_page.dart';
import 'package:baby_buy/pages/product_page.dart';
import 'package:baby_buy/providers/product_provider.dart';
import 'package:baby_buy/utils/elev_button_style.dart';
import 'package:baby_buy/utils/extensions.dart';
import 'package:baby_buy/utils/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    // final userName = context.watch<SignProvider>().userName;
    final userEmail = FirebaseAuth.instance.currentUser!;
    final imageProvider = Provider.of<ProductProvider>(context);
    final image = imageProvider.imageFile;
    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        title: StyleText(
          text: "Baby Buy",
          textWeight: true,
          textSize: 30,
          textColor: Colors.lightBlueAccent,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 2,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.lightBlueAccent),
      ),
      drawer: SafeArea(
        child: Drawer(
        shadowColor: Colors.lightBlueAccent,
          backgroundColor: Colors.black87,
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
                          backgroundColor: Colors.grey,
                          title: StyleText(
                            text: "Choose Image from:",
                            textWeight: true,
                            textColor: Colors.black,
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    backgroundColor: Colors.white,
                    backgroundImage: image != null ? FileImage(image) : null,
                    child: image == null ? Icon(Icons.person, size: 60) : null,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: StyleText(
                  text: "Welcome",
                  textColor: Colors.white,
                  textWeight: true,
                ),
              ),
              Center(
                child: Text(
                  userEmail.email!,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Colors.white,
                  ),
                ),
              ),
              Divider(thickness: 1, color: Colors.lightBlueAccent),
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
                    color: Colors.white,
                  ),
                ),
                icon: Icon(
                  Icons.account_tree_sharp,
                  size: 50,
                  color: Colors.white,
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
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: Icon(Icons.category, size: 50, color: Colors.white),
              ),
              SizedBox(height: 30),
              Divider(thickness: 1, color: Colors.lightBlueAccent),
              SizedBox(height: 20),
              TextButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      backgroundColor: Colors.grey,
                      title: StyleText(
                        text: "Send SMS",
                        textColor: Colors.black,
                        textWeight: true,
                        textSize: 26,
                      ),
                      content: StyleText(
                        text: "Sorry, this feature is not available right now.",
                        textColor: Colors.black,
                        textSpace: 1,
                      ),
                      actions: [
                        ElevButtonStyle(
                          buttonText: 'Okay',
                          buttonPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.message, size: 50, color: Colors.white),
                label: Text(
                  "Send SMS",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Divider(thickness: 1, color: Colors.lightBlueAccent),
              SizedBox(height: 50),
              TextButton.icon(
                onPressed: () {
                  context.signProvider.signUserOut();
                },
                label: Text(
                  "LogOut",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                icon: Icon(Icons.logout, size: 50, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.lightBlueAccent[100],
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap: (int index) {
          currentPage(index);
        },

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 40, color: Colors.white),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category, size: 40, color: Colors.white),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_tree_sharp, size: 40, color: Colors.white),
            label: "Product",
          ),
        ],
        backgroundColor: Colors.black,
      ),
    );
  }

  void currentPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
