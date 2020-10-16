import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helsim/model/user_manager.dart';
import 'package:provider/provider.dart';

class MinhaContaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.black,
            height: 180,
            child: Column(
              children: <Widget>[
                SizedBox(width: 10,),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 10, bottom: 10),
                  color: Colors.white,
                  width: 70,
                  height: 70,
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: <Widget>[
                        Image.asset("images/Lobo_maquina.png"),
                      ],
                    ),
                  ),
                ),
                Consumer<UserManager>(
                    builder: (_, userManager, __){
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Olá, ${userManager.user?.name ?? 'Convidado'}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 10,),
                              GestureDetector(
                                onTap: (){
                                  if(userManager.isLoggedIn){
                                    userManager.signOut();
                                    Navigator.of(context).pushNamed('/base');
                                  } else {
                                    Navigator.of(context).pushNamed('/login');
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      userManager.isLoggedIn
                                          ? 'Sair'
                                          : 'Entre ou Cadastre-se▶',
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          GestureDetector(
            onTap: (){

            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 50,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      child: Icon(
                        Icons.person, size: 30,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Meu Perfil', style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                              ),
                              Text('Alterer seus dados', style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: Icon(
                        Icons.arrow_forward_ios, size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(color: Colors.black,),
          GestureDetector(
            onTap: (){

            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 50,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      child: Icon(
                        Icons.done, size: 30,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Cupons', style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                              ),
                              Text('Meus cupons de desconto', style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      child: Icon(
                        Icons.arrow_forward_ios, size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(color: Colors.black,),
          GestureDetector(
            onTap: (){

            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 50,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      child: Icon(
                        Icons.account_balance_wallet, size: 30,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Formas de pagamentos', style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                              ),
                              Text('Minhas formas de pagamentos', style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      child: Icon(
                        Icons.arrow_forward_ios, size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(color: Colors.black,),
          GestureDetector(
            onTap: (){

            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 50,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      child: Icon(
                        Icons.location_on, size: 30,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Endereços', style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                              ),
                              Text('Meus endereços', style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      child: Icon(
                        Icons.arrow_forward_ios, size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(color: Colors.black,),
          GestureDetector(
            onTap: (){

            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 50,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      child: Icon(
                        Icons.add_alert, size: 30,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Notificões', style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                              ),
                              Text('Minha central de notificação', style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      child: Icon(
                        Icons.arrow_forward_ios, size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(color: Colors.black,),
          GestureDetector(
            onTap: (){

            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 50,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      child: Icon(
                        Icons.chat, size: 30,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Chat', style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                              ),
                              Text('Minhas conversas', style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      child: Icon(
                        Icons.arrow_forward_ios, size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(color: Colors.black,),
          SizedBox(height: 20,),
          Consumer<UserManager>(
            builder: (_, userManager, __){
              if(userManager.adminEnable){
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Para Admins:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed('/admin_users');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 50,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 50,
                                child: Icon(
                                  Icons.settings, size: 30,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15, left: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Usuários', style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 50,
                                child: Icon(
                                  Icons.arrow_forward_ios, size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(color: Colors.black,),
                    GestureDetector(
                      onTap: (){

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 50,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 50,
                                child: Icon(
                                  Icons.settings, size: 30,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15, left: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Pedidos', style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 50,
                                child: Icon(
                                  Icons.arrow_forward_ios, size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          )
        ],
      )
      );
  }
}
