import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:helsim/model/cart_manager.dart';
import 'package:helsim/model/product.dart';
import 'package:helsim/model/user_manager.dart';
import 'package:helsim/screens/products/components/size_widget.dart';
import 'package:provider/provider.dart';

class TelaProductScreen extends StatelessWidget {

  TelaProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.name),
          centerTitle: true,
          actions: <Widget>[
            Consumer<UserManager>(
              builder: (_, userManager, __){
                if(userManager.adminEnable){
                  return IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: (){
                        Navigator.of(context).pushReplacementNamed(
                            '/edit_product',
                          arguments: product
                        );
                    },
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: Carousel(
                  images: product.images.map((url){
                    return NetworkImage(url);
                  }).toList(),
                  dotSize: 4,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.black,
                  autoplay: false,
                  dotSpacing: 15,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600]
                      ),
                    ),
                  ),
                  Text(
                    'R\$ ${product.basePrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Descrição:',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                      ),
                    ),
                  ),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Tamanho:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: product.sizes.map((s){
                      return SizeWidget(size: s);
                    }).toList()
                  ),
                  const SizedBox(height: 20,),
                  if(product.hasStock)
                  Consumer2<UserManager, Product>(
                    builder: (_, userManager, product, __){
                      return SizedBox(
                        height: 44,
                        child: RaisedButton(
                          onPressed: product.selectedSize != null ? (){
                            if(userManager.isLoggedIn){
                              context.read<CartManager>().addToCard(product);
                              Navigator.of(context).pushNamed('/Cart');
                            } else {
                              Navigator.of(context).pushNamed('/login');
                            }
                          } : null,
                          color: Colors.black,
                          textColor: Colors.white,
                          child: Text(
                            userManager.isLoggedIn
                                ? 'Adicionar ao Carrinho'
                                : 'Entre para Comprar', style: TextStyle(fontSize: 18),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
