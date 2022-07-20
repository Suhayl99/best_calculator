import 'package:best_calculator/change_theme.dart';
import 'package:best_calculator/ruler/ruler_utils.dart';
import 'package:flutter/material.dart';

import '../calculator/scale_widget.dart';

class Cooking extends StatefulWidget {
  const Cooking({Key? key}) : super(key: key);

  @override
  State<Cooking> createState() => _CookingState();
}

class _CookingState extends State<Cooking> {
  final List<String> cityName = [
   "gallon|gal(US)",
    "quart|qt lqd(US)",
    "pt|pt lqd(US)",
    "ounce|fl oz(US)",
    "cup|cup(US)",
    "tablesppon|tbsp(US)",
    "teaspoon|tbsp(US)",
    "gallon|gal(UK)",
    "quart|qt(UK)",
    "pink|pt(UK)",
    "ounce|fl oz(UK)",
    "cup|cup(UK)",
    "tablespoon|tbsp(UK)",
    "milliliter|mL(cc)"
  ];
  String? _value = "milliliter|mL(cc)";
  String count ="1";
    final List<double> qiymat = [
      0.000264, 0.00106, 0.00211, 0.0338, 0.0423, 0.0676, 0.203, 0.00022, 0.00088, 0.00176, 0.00352, 0.0563, 1
   ];
  double? sizeText=48;
  double value1=1;

  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
     return Column(
    children: [
       Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
          child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<String>(
                      itemHeight: 70,
                      dropdownColor: curFirstColor,
                      iconDisabledColor: curActiveMenuColor,
                      value: _value,
                      items: cityName
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                   Text(
                                e.split('|').last,
                                style:  TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.normal, color:curFirstColor),
                              ),
                               Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(bottom: 10),
                                 child: Text(
                                  e.split('|').first,
                                  style:  TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.normal, color:curSecondColor),
                              ),
                               ),
                                ],
                              )
                            ),
                          )
                          .toList(),
                      onChanged: (item) {
                        setState(() {
                           _value = item;
                          if(cityName.contains(_value)){
                              value1=qiymat[cityName.indexOf(_value!)];
                          }
                        });
                      },
                    ),
                     InkWell(
        onTap: (){
          Scaffold.of(context).showBottomSheet<void>(
            (BuildContext context) {
              return Container(
                height: size.height*0.44,
                color: curBgColor,
                child: Center(
                  child:  GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: size.height * 0.0016,
                crossAxisCount: 4,
                primary: false,
                children: [
                 button(curAppBarColor, "7", curActiveMenuColor),
                button(curAppBarColor, "8", curActiveMenuColor),
                button(curAppBarColor, "9", curActiveMenuColor),
                button(curAppBarColor, "⌫", curActiveMenuColor),
                button(curAppBarColor, "4", curActiveMenuColor),
                button(curAppBarColor, "5", curActiveMenuColor),
                button(curAppBarColor, "6", curActiveMenuColor),
                button(curAppBarColor, "OK", curActiveMenuColor),
                button(curAppBarColor, "1", curActiveMenuColor),
                button(curAppBarColor, "2", curActiveMenuColor),
                button(curAppBarColor, "3", curActiveMenuColor),
                button(curAppBarColor, "C", curActiveMenuColor),
                button(curAppBarColor, ".", curActiveMenuColor),
                button(curAppBarColor, "0", curActiveMenuColor),
                button(curAppBarColor, "00", curActiveMenuColor),
                 button(curAppBarColor, "▽", curActiveMenuColor),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Expanded(child: Text(count, style:  TextStyle(color: curActiveMenuColor, fontSize: sizeText),)),
      ),
                  ],
                ),
        ),
      SizedBox(
        height: 450,
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
             unitElements(cityName[0].split("|").first, cityName[0].split("|").last, 0.000264,  curFirstColor, count, value1),
             unitElements(cityName[1].split("|").first, cityName[1].split("|").last, 0.00106, curSecondColor, count, value1),
             unitElements(cityName[2].split("|").first, cityName[2].split("|").last,  0.00211, curFirstColor, count, value1),
             unitElements(cityName[3].split("|").first, cityName[3].split("|").last, 0.0338, curSecondColor, count, value1),
             unitElements(cityName[4].split("|").first, cityName[4].split("|").last, 0.0423, curFirstColor, count, value1),
             unitElements(cityName[5].split("|").first, cityName[5].split("|").last, 0.0676, curSecondColor, count, value1),
             unitElements(cityName[6].split("|").first, cityName[6].split("|").last, 0.203, curFirstColor, count, value1),
             unitElements(cityName[7].split("|").first, cityName[7].split("|").last,0.00022,  curSecondColor, count, value1),
             unitElements(cityName[8].split("|").first, cityName[8].split("|").last, 0.00088, curFirstColor, count, value1),
             unitElements(cityName[9].split("|").first, cityName[9].split("|").last, 0.00176, curSecondColor, count, value1),
             unitElements(cityName[10].split("|").first, cityName[10].split("|").last, 0.00352, curFirstColor, count, value1),
             unitElements(cityName[11].split("|").first, cityName[11].split("|").last, 0.00352, curSecondColor, count, value1),
             unitElements(cityName[12].split("|").first, cityName[12].split("|").last, 0.0563, curFirstColor, count, value1),
             unitElements(cityName[13].split("|").first, cityName[13].split("|").last, 1, curSecondColor, count, value1),
          ],
        ),
      ),
    ],
  );
  }

   Widget button(Color bgclr, String text, Color numTxtClr) {
    return scaleWidget(
      onTap: () => btnOnClick(text),
      scale: 0.7,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgclr,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: numTxtClr,
          ),
        ),
      ),
    );
  }

    String countText="";
  btnOnClick(String text) {
    setState(() {
      if (text == "C") {
         count="1";
         countText="";
      } else if (text == "⌫"){
        if (count.length<2) {
        count = "1";
         countText="";
        } else {
          count=countText;
        }
      }else if (text == "▽"){
        count="1";
        Navigator.pop(context);
      } else if (text == "OK") {
        Navigator.pop(context);
      }else if(text == "."){
        var isPoint = countText.split('.').toList().length;
        if (isPoint == 2 || countText.length >1) {
          countText += ".";
          count=countText;
        }else{
          count="1";
          countText+="0.";
          count=countText;
        }
      }else{
        countText+=text;
        count=countText;
      }

      if(count.length>4){
        sizeText=4*sizeText!/count.length;
      }
    });
  }
}