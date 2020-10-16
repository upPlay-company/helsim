import 'package:flutter/material.dart';
import 'package:helsim/helpers/validators.dart';
import 'package:helsim/model/user.dart';
import 'package:helsim/model/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class LoginScreen extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Entre Agora!', style: TextStyle(fontSize: 25),),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            child: const Text('CRIAR CONTA',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
                builder: (_, userManager, __){
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: <Widget>[
                      TextFormField(
                        controller: emailController,
                        enabled: !userManager.loading,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        obscureText: false,
                        validator: (email){
                          if(!emailValid(email)){
                            return 'Email inválido';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            hintText: 'E-mail',
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            contentPadding: const EdgeInsets.only(
                                top: 30,
                                right: 30,
                                bottom: 30,
                                left: 5
                            )
                        ),
                      ),
                      const SizedBox(height: 16,),
                      TextFormField(
                        controller: passController,
                        enabled: !userManager.loading,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        obscureText: true,
                        validator: (pass){
                          if(pass.isEmpty || pass.length < 6){
                            return 'Senha Inválida';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            hintText: 'Senha',
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            contentPadding: const EdgeInsets.only(
                                top: 30,
                                right: 30,
                                bottom: 30,
                                left: 5
                            )
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: (){

                          },
                          padding: EdgeInsets.zero,
                          child: const Text(
                              'Esqueci minha senha'
                          ),
                        ),
                      ),
                      const SizedBox(height: 16,),
                      SizedBox(
                        height: 44,
                        child: RaisedButton(
                          onPressed: userManager.loading ? null : (){
                            if(formKey.currentState.validate()){
                              userManager.signIn(
                                  user: User(
                                      email: emailController.text,
                                      password: passController.text
                                  ),
                                  onFail: (e){
                                    scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          content: Text('Falha ao entrar: $e',
                                            style: TextStyle(fontSize: 16, color: Colors.redAccent),
                                          ),
                                          backgroundColor: Colors.black,
                                        )
                                    );
                                  },
                                  onSuccess: (){
                                    Navigator.of(context).pop();
                                  }
                              );
                            }
                          },
                          color: Colors.black,
                          disabledColor: Colors.black.withAlpha(100),
                          textColor: Colors.white,
                          child: userManager.loading ?
                          const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ) :
                          const Text('Entrar', style: TextStyle(fontSize: 19, color: Colors.white),),
                        ),
                      )
                    ],
                  );
                }
            ),
          ),
        ),
      ),
    );
  }
}
