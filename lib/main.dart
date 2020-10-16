import 'package:flutter/material.dart';
import 'package:helsim/model/admin_users_manager.dart';
import 'package:helsim/model/cart_manager.dart';
import 'package:helsim/model/home_manager.dart';
import 'package:helsim/model/orders_manager.dart';
import 'package:helsim/model/product_manager.dart';
import 'package:helsim/model/user_manager.dart';
import 'package:helsim/screens/address/address_screen.dart';
import 'package:helsim/screens/admin/admin_users/admins_users_screen.dart';
import 'package:helsim/screens/base/base_screen.dart';
import 'package:helsim/screens/cart/cart_screen.dart';
import 'package:helsim/screens/checkout/checkout_screen.dart';
import 'package:helsim/screens/confirmation/confirmation_screen.dart';
import 'package:helsim/screens/edit_product/edit_product_screen.dart';
import 'package:helsim/screens/login/login_screen.dart';
import 'package:helsim/screens/minhaconta/minhaconta_screen.dart';
import 'package:helsim/screens/orders/orders_screen.dart';
import 'package:helsim/screens/products/telaproduct_screen.dart';
import 'package:helsim/screens/select_product/select_product_screen.dart';
import 'package:helsim/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';
import 'model/order.dart';
import 'model/product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
          cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, OrdersManager>(
          create: (_) => OrdersManager(),
          lazy: false,
          update: (_, userManager, ordersManager) =>
            ordersManager..updateUser(userManager.user),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUsersManager) =>
            adminUsersManager..updateUser(userManager),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.redAccent,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            elevation: 0,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings){
          switch(settings.name){
            case '/signup':
              return MaterialPageRoute(
                  builder: (_) => SignupScreen()
              );
            case '/login':
              return MaterialPageRoute(
                  builder: (_) => LoginScreen()
              );
            case '/Conta':
              return MaterialPageRoute(
                  builder: (_) => MinhaContaScreen()
              );
            case '/product':
              return MaterialPageRoute(
                  builder: (_) => TelaProductScreen(
                    settings.arguments as Product
                  )
              );
            case '/Cart':
              return MaterialPageRoute(
                  builder: (_) => CartScreen(),
                  settings: settings
              );
            case '/admin_users':
              return MaterialPageRoute(
                  builder: (_) => AdminsUsersScreen()
              );
            case '/edit_product':
              return MaterialPageRoute(
                  builder: (_) => EditProductScreen(
                    settings.arguments as Product
                  )
              );
            case '/vincular_product':
              return MaterialPageRoute(
                  builder: (_) => SelectProductScreen()
              );
            case '/address':
              return MaterialPageRoute(
                  builder: (_) => AddressScreen()
              );
            case '/checkout':
              return MaterialPageRoute(
                  builder: (_) => CheckoutScreen()
              );
            case '/meus_pedidos':
              return MaterialPageRoute(
                  builder: (_) => OrdersScreen()
              );
            case '/confirmation':
              return MaterialPageRoute(
                  builder: (_) => ConfirmationScreen(
                    settings.arguments as Order
                  )
              );
            case '/base':
            default:
              return MaterialPageRoute(
                  builder: (_) => BaseScreen(),
              );
          }
        },
      ),
    );
  }
}

