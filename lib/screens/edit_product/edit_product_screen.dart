import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helsim/model/product.dart';
import 'package:helsim/model/product_manager.dart';
import 'package:helsim/screens/edit_product/components/sizes_form.dart';
import 'package:provider/provider.dart';
import 'components/image_form.dart';

class EditProductScreen extends StatelessWidget {

  EditProductScreen(Product p):
        editing = p != null,
        product = p != null ? p.clone() : Product();

  final Product product;
  final bool editing;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(editing ? 'Editando Produto' : 'Criar Produto'),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              ImagesForm(product),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      initialValue: product.name,
                      decoration: InputDecoration(
                          hintText: 'Título',
                          border: InputBorder.none
                      ),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                      ),
                      validator: (name){
                        if(name.length < 6)
                          return 'Título muito curto!';
                        return null;
                      },
                      onSaved: (name) => product.name = name,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'A partir de:',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13
                        ),
                      ),
                    ),
                    Text(
                      'R\$ ...',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        'Descrição:',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    TextFormField(
                      initialValue: product.description,
                      style: TextStyle(
                        fontSize: 16
                      ),
                      decoration: InputDecoration(
                          hintText: 'Descrição',
                          border: InputBorder.none
                      ),
                      maxLines: null,
                      validator: (desc){
                        if(desc.length < 10)
                          return 'Descrição muito curta!';
                        return null;
                      },
                      onSaved: (desc) => product.description = desc,
                    ),
                    SizesForm(product),
                    const SizedBox(height: 20,),
                    Consumer<Product>(
                      builder: (_, product, __){
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: SizedBox(
                            height: 44,
                            child: RaisedButton(
                              onPressed: !product.loading ? () async {
                                if(formKey.currentState.validate()){
                                  formKey.currentState.save();
                                  await product.save();
                                  Navigator.of(context).pop();
                                  context.read<ProductManager>().update(product);
                                }
                              }: null,
                              color: Colors.black,
                              textColor: Colors.white,
                              disabledColor: Colors.black.withAlpha(100),
                              child: product.loading
                              ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ): const Text('Salvar', style: TextStyle(fontSize: 18),),
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
      ),
    );
  }
}
