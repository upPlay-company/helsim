import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helsim/model/home_manager.dart';
import 'package:helsim/model/user_manager.dart';
import 'package:helsim/screens/home/components/section.banner.dart';
import 'package:helsim/screens/home/components/section_list.dart';
import 'package:helsim/screens/home/components/section_list2.dart';
import 'package:provider/provider.dart';
import 'components/add_section_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            snap: true,
            floating: true,
            elevation: 0,
            backgroundColor: Colors.redAccent,
            automaticallyImplyLeading: false,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 27),
              child: Center(
                child: Container(
                  height: 50,
                  width: 150,
                  child: Row(
                    children: <Widget>[
                      Image.asset("images/Lobo_maquina.png"),
                      Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Text(
                          'HELSIM', style: TextStyle(fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.shopping_cart, size: 30,),
                  color: Colors.black,
                  onPressed: () => Navigator.of(context).pushNamed('/Cart')
                  ),
              Consumer2<UserManager, HomeManager>(
                builder: (_, userManager, homeManager,__){
                  if(userManager.adminEnable && !homeManager.loading){
                    if(homeManager.editing){
                      return PopupMenuButton(
                        icon: Icon(Icons.more_vert, color: Colors.black),
                        onSelected: (e){
                          if(e == 'Salvar'){
                            homeManager.saveEditing();
                          } else {
                            homeManager.discardEditing();
                          }
                        },
                        itemBuilder: (_){
                          return ['Salvar', 'Descartar'].map((e){
                            return PopupMenuItem(
                              value: e,
                              child: Text(e),
                            );
                          }).toList();
                        },
                      );
                    } else {
                      return IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.black,
                        onPressed: homeManager.enterEditing,
                      );
                    }
                  } else return Container();
                },
              )
            ],
          ),
          Consumer<HomeManager>(
            builder: (_, homeManager, __){
              if(homeManager.loading){
                return SliverToBoxAdapter(
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                    backgroundColor: Colors.transparent,
                  ),
                );
              }

              final List<Widget> children = homeManager.sections
                  .map<Widget>((section) {
                    switch(section.type){
                      case 'list' :
                        return SectionList(section);
                      case 'banners' :
                        return SectionBanner(section);
                      case 'staggered' :
                        return SectionList2(section);
                      default:
                        return Container();
                    }
              }).toList();

              if(homeManager.editing)
                children.add(AddSectionWidget());

              return SliverList(
                delegate: SliverChildListDelegate(children),
              );
            },
          )
        ],
      ),
    );
  }
}
