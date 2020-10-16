import 'package:flutter/material.dart';
import 'package:helsim/common/empty_card.dart';
import 'package:helsim/common/login_cart.dart';
import 'package:helsim/common/price_card.dart';
import 'package:helsim/model/cart_manager.dart';
import 'package:helsim/screens/cart/components/cart_tile.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Carrinho'),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(
        builder: (_, cartManager, __){
          if(cartManager.user == null){
            return LoginCart();
          }

          if(cartManager.items.isEmpty){
            return EmptyCard(
              iconData: Icons.remove_shopping_cart,
              title: 'Nenhum Produto no Carrinho!',
            );
          }

          return ListView(
            children: <Widget>[
              Column(
              children: cartManager.items.map((cartProduct) =>
                  CartTile(cartProduct)).toList(),
              ),
              PriceCard(
                buttonText: 'Continuar para Entrega',
                onPressed: cartManager.isCartValid ? (){
                  Navigator.of(context).pushNamed('/address');
                } : null,
              ),
            ],
          );
        },
      ),
    );
  }
}