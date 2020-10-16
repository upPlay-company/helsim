import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helsim/model/product_manager.dart';
import 'package:helsim/model/user_manager.dart';
import 'package:helsim/screens/products/components/products_list_tile.dart';
import 'package:helsim/screens/products/components/search_dialog.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Consumer<ProductManager>(
        builder: (_, productManager, __){
              if(productManager.search.isEmpty){
                return const Text('Produtos HELSIM');
              } else {
                return LayoutBuilder(
                  builder: (_, constraints){
                    return GestureDetector(
                      onTap: () async {
                        final search = await showDialog<String>(context: context,
                            builder: (_) => SearchDialog(
                              productManager.search
                            ));
                        if(search != null){
                          productManager.search = search;
                        }
                      },
                      child: Container(
                          width: constraints.biggest.width,
                          child: Text(
                            productManager.search,
                            textAlign: TextAlign.center,
                          )
                      ),
                    );
                  },
                );
              }
          }
        ),
        centerTitle: true,
        actions: <Widget>[
          Consumer<ProductManager>(
            builder: (_, productManager, __){
              if(productManager.search.isEmpty){
                return IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async{
                    final search = await showDialog<String>(context: context,
                        builder: (_) => SearchDialog(
                            productManager.search
                        ));
                    if(search != null){
                      productManager.search = search;
                    }
                  },
                );
              } else {
                return IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () async{
                    productManager.search = '';
                  },
                );
              }
            }
          ),
          Consumer<UserManager>(
            builder: (_, userManager, __){
              if(userManager.adminEnable){
                return IconButton(
                  icon: Icon(Icons.add),
                  onPressed: (){
                    Navigator.of(context).pushNamed(
                      '/edit_product',
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
      body: Consumer<ProductManager>(
        builder: (_, productManager, __){
          final filteredProducts = productManager.filteredProducts;
          return ListView.builder(
            padding: const EdgeInsets.all(6),
            itemCount: filteredProducts.length,
              itemBuilder: (_, index){
                return ProductListTile(filteredProducts[index]);
              }
          );
        },
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: (){
          Navigator.of(context).pushNamed('/Cart');
        },
        child: Icon(Icons.shopping_cart),
      ),
      );
  }
}
