import 'dart:developer';
import 'package:admin/presentation/Search/search_screen.dart';
import 'package:admin/presentation/home_screen/widgets/product_tiles.dart';
import 'package:admin/presentation/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'widgets/add_new_product.dart';
import 'widgets/order_widget.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: kMainBgColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              foregroundColor: Colors.black,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const SearchScreen();
                            },
                          ));
                        },
                        icon: const Icon(Icons.search),
                      ),
                      GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance.signOut().then((value) {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return const LogIn();
                              },
                            ), (route) => false);
                          }).onError((error, stackTrace) {
                            log("Error ${error.toString()}");
                          });
                        },
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person_3_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              title: const Text(
                "Fashion Store",
                style: TextStyle(
                  color: kTextBlackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      'Products',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Orders',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 3.0,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                ProductsTiles(),
                const ActiveWidget(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddNewProductScreen(),
                    ),
                  );
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.black),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(
                          horizontal: size.width * 0.28, vertical: 20)),
                ),
                child: const Text(
                  'Add Product',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
