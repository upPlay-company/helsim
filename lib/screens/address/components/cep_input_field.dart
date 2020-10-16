import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helsim/common/custom_icon_button.dart';
import 'package:helsim/model/address.dart';
import 'package:helsim/model/cart_manager.dart';
import 'package:provider/provider.dart';

class CepInputField extends StatefulWidget {

  CepInputField(this.address);

  final Address address;

  @override
  _CepInputFieldState createState() => _CepInputFieldState();
}

class _CepInputFieldState extends State<CepInputField> {

  final TextEditingController cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();

    if(widget.address.zipCode == null)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            enabled: !cartManager.loading,
            controller: cepController,
            decoration: const InputDecoration(
              isDense: true,
              labelText: 'CEP',
              hintText: '12.345-678'
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter(),
            ],
            keyboardType: TextInputType.number,
            validator: (cep){
              if(cep.isEmpty)
                return 'Campo obrigatório';
              else if(cep.length != 10)
                return 'CEP Inválido';
              return null;
            },
          ),
          if(cartManager.loading)
            LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.black),
              backgroundColor: Colors.transparent,
            ),
          RaisedButton(
            onPressed: !cartManager.loading ? () async {
              if(Form.of(context).validate()){
                try {
                  await context.read<CartManager>().getAddress(cepController.text);
                } catch (e){
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$e', style: TextStyle(color: Colors.redAccent, fontSize: 16),),
                      backgroundColor: Colors.black,
                    )
                  );
                }
              }
            }: null,
            color: Colors.black,
            disabledColor: Colors.black.withAlpha(100),
            child: const Text('Buscar CEP',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      );
    else
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'CEP: ${widget.address.zipCode}',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            CustomIconButton(
              iconData: Icons.edit,
              color: Colors.redAccent,
              size: 20,
              onTap: (){
                context.read<CartManager>().removeAddress();
              },
            )
          ],
        ),
      );
  }
}
