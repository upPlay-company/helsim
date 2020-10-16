import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helsim/model/section.dart';

class SectionBanner extends StatelessWidget {

  const SectionBanner(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 200,
                  width: 300,
                  child: Carousel(
                  images: [
                      NetworkImage('https://images.pexels.com/photos/1459359/pexels-photo-1459359.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                      NetworkImage('https://images.pexels.com/photos/374677/pexels-photo-374677.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                      NetworkImage('https://images.pexels.com/photos/135620/pexels-photo-135620.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                      NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRxd98Rc22oOYTSlBHcJoJo9FFUJ5AxMOHHlw&usqp=CAU'),
                      ],
                      dotBgColor: Colors.transparent,
                      dotColor: Colors.black,
                      dotSpacing: 15,
                      animationDuration: Duration(milliseconds: 1000),
                      ),
                    ),
                  ]
                )
              ],
            ),
      ),
        );
    }
}
