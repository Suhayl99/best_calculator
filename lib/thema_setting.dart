import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'change_theme.dart';



class ThemaPage extends StatefulWidget {
  const ThemaPage({Key? key}) : super(key: key);

  @override
  State<ThemaPage> createState() => _ThemaPageState();
}

class _ThemaPageState extends State<ThemaPage> {
   @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: curAppBarColor,
      ),
    );
    return  Container(
            color:  const Color(0xffC1C1C1),
            padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
            child: ListView(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _themeButton("1"),
                  _themeButton("2"),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _themeButton("3"),
                
                  _themeButton("4"),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _themeButton("5"),
                  
                  _themeButton("6"),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _themeButton("7"),
              
                  _themeButton("8"),
                ],
              ),
              const SizedBox(
                height: 14,
              ),              
            ]),
    );
  }
 GestureDetector _themeButton(String image) {
  var thema=int.parse(image);
    return GestureDetector(
      onTap: () {
          setState(() {
          changeThemeColor(thema);
          });
          Navigator.pop(context);      
      },
      child: Image.asset(
        "assets/calculator/$image.png",
        height: 250,
        width: 120,
      ),
    );
  }

}

