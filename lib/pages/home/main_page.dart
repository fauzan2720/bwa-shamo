// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:shamo/pages/home/chat_page.dart';
import 'package:shamo/pages/home/home_page.dart';
import 'package:shamo/pages/home/profile_page.dart';
import 'package:shamo/pages/home/wishlist_page.dart';
import 'package:shamo/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  Widget cartButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/cart');
      },
      backgroundColor: secondaryColor,
      child: Image.asset(
        'assets/images/ic_cart.png',
        width: 20,
      ),
    );
  }

  Widget body() {
    switch (currentIndex) {
      case 0:
        return const HomePage();
        break;
      case 1:
        return const ChatPage();
        break;
      case 2:
        return const WishlistPage();
        break;
      case 3:
        return const ProfilePage();
        break;
      default:
        return const HomePage();
    }
  }

  Widget customBottomNav() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(30),
      ),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10, // membuat margin
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          backgroundColor: bgColor4,
          currentIndex: currentIndex,
          onTap: (value) {
            // print(value);
            setState(() {
              currentIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                child: Image.asset(
                  'assets/images/ic_home.png',
                  width: 21,
                  color: currentIndex == 0
                      ? primaryColor
                      : const Color(0xff808191),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(top: 20, bottom: 10, right: 45),
                child: Image.asset(
                  'assets/images/ic_chat.png',
                  width: 20,
                  color: currentIndex == 1
                      ? primaryColor
                      : const Color(0xff808191),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(top: 20, bottom: 10, left: 45),
                child: Image.asset(
                  'assets/images/ic_love.png',
                  width: 20,
                  color: currentIndex == 2
                      ? primaryColor
                      : const Color(0xff808191),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                child: Image.asset(
                  'assets/images/ic_profile.png',
                  width: 18,
                  color: currentIndex == 3
                      ? primaryColor
                      : const Color(0xff808191),
                ),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentIndex == 0 ? bgColor1 : bgColor3,
      floatingActionButton: cartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
