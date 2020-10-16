import 'package:flutter/material.dart';
import 'package:helsim/model/cart_manager.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatelessWidget {

  const PriceCard({this.buttonText, this.onPressed});

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final productPrice = cartManager.productsPrice;
    final deliveryPrice = cartManager.deliveryPrice;
    final totalPrice = cartManager.totalPrice;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Resumo do Pedido:',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16
              ),
            ),
            SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'SubTotal:'
                ),
                Text(
                    'R\$ ${productPrice.toStringAsFixed(2)}'
                ),
              ],
            ),
            const Divider(),
            if(deliveryPrice != null)
              ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        'Entrega:'
                    ),
                    Text(
                        'R\$ ${deliveryPrice.toStringAsFixed(2)}'
                    ),
                  ],
                ),
                const Divider(),
              ],
            SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                    'Total:', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                Text(
                    'R\$ ${totalPrice.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)
                ),
              ],
            ),
            SizedBox(height: 8,),
            RaisedButton(
              color: Colors.black,
              disabledColor: Colors.white,
              textColor: Colors.white,
              onPressed: onPressed,
              child: Text(buttonText, style: TextStyle(fontSize: 16),),),
            ]
          )
        ),
      );
  }
}
