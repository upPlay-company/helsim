import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:helsim/model/admin_users_manager.dart';
import 'package:provider/provider.dart';

class AdminsUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuários'),
        centerTitle: true,
      ),
      body: Consumer<AdminUsersManager>(
        builder: (_, adminUsersManager, __){
          return AlphabetListScrollView(
            itemBuilder: (_, index){
              return ListTile(
                title: Text(
                  adminUsersManager.users[index].name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
                subtitle: Text(
                    adminUsersManager.users[index].email,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.black
                  ),
                ),
              );
            },
            highlightTextStyle: TextStyle(
              color: Colors.red,
              fontSize: 20
            ),
            indexedHeight: (index) => 80,
            strList: adminUsersManager.names,
            showPreview: true,
          );
        },
      )
    );
  }
}
