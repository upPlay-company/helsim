import 'package:flutter/material.dart';
import 'package:helsim/model/home_manager.dart';
import 'package:helsim/model/section.dart';
import 'package:provider/provider.dart';

class AddSectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final homeManager = context.watch<HomeManager>();

    return Row(
      children: <Widget>[
        Expanded(
          child: FlatButton(
            onPressed: (){
              homeManager.addSection(Section(type: 'list'));
            },
            textColor: Colors.black,
            child: const Text('Adicionar Lista',
            style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        Expanded(
          child: FlatButton(
            onPressed: (){
              homeManager.addSection(Section(type: 'staggered'));
            },
            textColor: Colors.black,
            child: const Text('Adicionar Grade',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
