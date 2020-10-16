import 'package:flutter/material.dart';
import 'package:helsim/helpers/validators.dart';
import 'package:helsim/model/user.dart';
import 'package:helsim/model/user_manager.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
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
                      enabled: !userManager.loading,
                      validator: (name){
                        if(name.isEmpty)
                          return 'Campo obrigatório';
                        else if(name.trim().split(' ').length <= 1)
                          return 'Preencha seu nome completo';
                        return null;
                      },
                      onSaved: (name) => user.name = name,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          hintText: 'Nome Completo',
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
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      obscureText: false,
                      enabled: !userManager.loading,
                      validator: (email){
                        if(email.isEmpty)
                          return 'Campo obrigatório';
                        else if(!emailValid(email))
                          return 'E-mail inválido';
                        return null;
                      },
                      onSaved: (email) => user.email = email,
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
                      autocorrect: false,
                      obscureText: true,
                      enabled: !userManager.loading,
                      validator: (pass){
                        if(pass.isEmpty)
                          return 'Campo obrigatório';
                        else if(pass.length < 6)
                          return 'Senha muito curta';
                        return null;
                      },
                      onSaved: (pass) => user.password = pass,
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
                    const SizedBox(height: 16,),
                    TextFormField(
                      autocorrect: false,
                      obscureText: true,
                      enabled: !userManager.loading,
                      validator: (pass){
                        if(pass.isEmpty)
                          return 'Campo obrigatório';
                        else if(pass.length < 6)
                          return 'Senha muito curta';
                        return null;
                      },
                      onSaved: (pass) => user.confirmPassword = pass,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          hintText: 'Confirme sua Senha',
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
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        color: Colors.black,
                        disabledColor: Colors.black.withAlpha(100),
                        textColor: Colors.white,
                        onPressed: userManager.loading ? null : (){
                          if(formKey.currentState.validate()){
                            formKey.currentState.save();

                            if(user.password != user.confirmPassword){
                              scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: const Text('Senhas não coincidem!'),
                                    backgroundColor: Colors.red,
                                  ));
                              return;
                            }
                            userManager.signUp(
                                user: user,
                                onSuccess: (){
                                  Navigator.of(context).pop();
                                },
                                onFail: (e){
                                  scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text('Falha ao cadastrar: $e',
                                          style: TextStyle(fontSize: 16, color: Colors.redAccent),
                                        ),
                                        backgroundColor: Colors.black,
                                      )
                                  );
                                }
                            );
                          }
                        },
                        child: userManager.loading ?
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ) :
                        const Text('Criar Conta', style: TextStyle(fontSize: 18),),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
