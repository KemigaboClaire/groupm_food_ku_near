// ignore_for_file: prefer_const_constructors

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:recesslibpjt/provider/sign_in_provider.dart';
import 'package:recesslibpjt/screens/login_screen.dart';
import 'package:recesslibpjt/screens/my_drawer_header.dart';
import 'package:recesslibpjt/screens/wallet_screen.dart';
import 'package:recesslibpjt/utils/next_screen.dart';
import 'food.dart';
import 'foodmenu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentPage = DrawerSections.home;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.orange[300],
      appBar: AppBar(
        backgroundColor: Colors.orange[800],
        title: Text('Food Ku Near', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Hello(),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(1, "Home", Icons.home,
              currentPage == DrawerSections.home ? true : false),
          menuItem(2, "Wallet", Icons.wallet,
              currentPage == DrawerSections.wallet ? true : false),
          menuItem(3, "SignOut", Icons.logout,
              currentPage == DrawerSections.SignOut ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    final sp = context.read<SignInProvider>();
    return Material(
      color: selected ? Colors.orangeAccent[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              // currentPage = DrawerSections.home;
              nextScreenReplace(context, HomeScreen());
            } else if (id == 2) {
              nextScreen(context, WalletScreen());
            } else if (id == 3) {
              // currentPage = DrawerSections.wallet;
              sp.userSignOut();
              nextScreenReplace(context, LogInScreen());
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections { home, SignOut, wallet }
