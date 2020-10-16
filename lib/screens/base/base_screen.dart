import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:helsim/screens/home/home_screen.dart';
import 'package:helsim/screens/minhaconta/minhaconta_screen.dart';
import 'package:helsim/screens/orders/orders_screen.dart';
import 'package:helsim/screens/products/products_screen.dart';
import 'package:helsim/screens/select_product/select_product_screen.dart';
import 'package:line_icons/line_icons.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ProductsScreen(),
    OrdersScreen(),
    MinhaContaScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
          ]),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: GNav(
                gap: 3,
                activeColor: Colors.white,
                iconSize: 23,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.black,
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: LineIcons.list,
                    text: 'Produtos',
                  ),
                  GButton(
                    icon: Icons.playlist_add_check,
                    text: 'Meus Pedidos',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Minha Conta',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index){
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        )
    );
  }
}
