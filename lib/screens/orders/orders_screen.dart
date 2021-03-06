import 'package:flutter/material.dart';
import 'package:helsim/common/empty_card.dart';
import 'package:helsim/common/login_cart.dart';
import 'package:helsim/model/orders_manager.dart';
import 'package:provider/provider.dart';

import 'components/order_tile.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Consumer<OrdersManager>(
        builder: (_, ordersManager, __){
          if(ordersManager.user == null){
            return LoginCart();
          }
          if(ordersManager.orders.isEmpty){
            return EmptyCard(
              title: 'Nenhum compra encontrada!',
              iconData: Icons.border_clear,
            );
          }
          return ListView.builder(
            itemCount: ordersManager.orders.length,
            itemBuilder: (_, index){
              return OrderTile(
                ordersManager.orders.reversed.toList()[index]
              );
            },
          );
        },
      ),
    );
  }
}
